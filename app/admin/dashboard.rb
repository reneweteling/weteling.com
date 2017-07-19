ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  
  page_action :invoice, method: :get do
    date = params[:date].to_date
    project = Project.find(params[:project_id])
    hours = project.hours.where(date: date.at_beginning_of_month..date.at_end_of_month).orderd

    html = render_to_string template: '/invoice/invoice', locals: {project: project, hours: hours, date: date}, layout: 'pdf'

    return render html: html if params[:type] == 'html'

    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Portrait')
    # kit.stylesheets << Rails.root.join('vendor/assets/custom/bootstrap/css/bootstrap.min.css')
    send_data kit.to_pdf, filename: "#{project.to_s}-#{date.to_s.parameterize}.pdf", type: 'application/pdf'
  end

  content do
    current = Time.now
    first = Hour.minimum(:date).at_beginning_of_month
    
    while current >= first do

      h2 current.strftime('%B %Y')

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
          Project.includes(:client, :hours => [:rate]).where(id: project_ids).order('clients.name').order(:name).each do |p|
            tr class: (i%2 == 1 ? 'even' : 'odd') do 
              hours = p.hours.where(date: current.at_beginning_of_month..current.at_end_of_month)
              td p.client 
              td p.name
              td hours.sum(:total_hours)
              td hours.map(&:rate).uniq.to_sentence
              td number_to_currency(hours.map{|h| h.total_hours * h.rate.rate }.inject(:+))
              td link_to(icon('file-pdf-o'), admin_dashboard_invoice_path(project_id: p.id, date: current.at_beginning_of_month.to_date, type: :pdf)) + " - " +
                link_to( icon('eye'), admin_dashboard_invoice_path(project_id: p.id, date: current.at_beginning_of_month.to_date, type: :html))
              i += 1
            end
          end
          
        end
      end
      current = current - 1.month
    end

  end
end


