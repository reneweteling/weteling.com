ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  
  page_action :invoice, method: :get do
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    project = Project.find(params[:project_id])
    hours = project.hours.where(date: start_date..end_date).orderd

    html = render_to_string template: '/invoice/invoice', locals: {project: project, hours: hours, start_date: start_date, end_date: end_date}, layout: 'pdf'

    return render html: html if params[:type] == 'html'

    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Portrait')
    send_data kit.to_pdf, filename: "#{project.to_s}-#{start_date.to_s.parameterize}-#{end_date.to_s.parameterize}.pdf", type: 'application/pdf'
  end

  controller do 
    before_action :set_filter

    def set_filter
      @filter = OpenStruct.new( start: (Date.today - 2.months).at_beginning_of_month, end: Date.today.at_end_of_month )

      if params[:filter].present?
        p = params.require(:filter).permit(:start, :end)
        @filter.start = Date.parse(p[:start])
        @filter.end = Date.parse(p[:end])
      end

    end

  end

  
  sidebar :date_filter do 
    render partial: 'date_filter'
  end

  content do

    @filter = OpenStruct.new( start: (Date.today - 2.months).at_beginning_of_month, end: Date.today.at_end_of_month )
    
    if params[:filter].present?
      p = params.require(:filter).permit(:start, :end)
      @filter.start = Date.parse(p[:start])
      @filter.end = Date.parse(p[:end])
    end
    
    hours = Hour.where(date: @filter.start..@filter.end)

    current = Time.now
    first = hours.minimum(:date).at_beginning_of_month

    while current >= first do
      month_total = 0.0
      

      table class: 'index_table index dashboard' do 
        thead do
          tr do
            th 'Client'
            th 'Project'
            th 'Total hours'
            th 'Rate'
            th 'Total'
            th ''
          end
        end
        tbody do
          i = 0
          project_ids = Hour.where(date: current.at_beginning_of_month..current.at_end_of_month).select(:project_id).distinct().pluck(:project_id)
          Project.includes(:client, :hours => [:rate]).where(id: project_ids).accessible_by(current_ability).order('clients.name').order(:name).each do |p|
            tr class: (i%2 == 1 ? 'even' : 'odd') do 
              start_date = current.at_beginning_of_month >= @filter.start ? current.at_beginning_of_month : @filter.start
              end_date = current.at_end_of_month <= @filter.end ? current.at_end_of_month : @filter.end
              hours = p.hours.where(date: start_date..end_date)
              project_total = hours.map{|h| h.total_hours * h.rate.rate }.inject(:+)
              month_total += project_total
              

              td p.client 
              # td "#{start_date.to_date} - #{end_date.to_date}"
              td p.name
              td hours.sum(:total_hours)
              td hours.map(&:rate).uniq.to_sentence
              td number_to_currency(project_total)
              td link_to(icon('file-pdf-o'), admin_dashboard_invoice_path(project_id: p.id, end_date: end_date.to_date, start_date: start_date.to_date, type: :pdf)) + " - " +
                 link_to( icon('eye'),       admin_dashboard_invoice_path(project_id: p.id, end_date: end_date.to_date, start_date: start_date.to_date, type: :html))
              i += 1
            end
          end
          
        end

        h2 do 
          span class: 'date' do
            current.strftime('%B %Y')
          end
          span class: 'total' do
            number_to_currency(month_total)
          end
        end

      end
      
      current = current - 1.month
    end

  end
end


