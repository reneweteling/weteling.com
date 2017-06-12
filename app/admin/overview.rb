# app/admin/calendar.rb
ActiveAdmin.register_page "Overview" do
  content do
    para "Hello World"

    table do 
      thead do
        tr do
          th 'Client'
          th 'Project'
          th 'Total hours'
          th 'Rate'
          th 'Total'
          th 'Date'
        end
      end
      tbody do
        current = Time.now
        first = Hour.minimum(:date)
        while current >= first do
          project_ids = Hour.where(date: current.at_beginning_of_month..current.at_end_of_month).select(:project_id).distinct().pluck(:project_id)
          Project.where(id, project_ids).orderd.find_each do |p|
            tr do 
              td p.client 
              td p.name
              td p.hours.sum(:total_hours)
              td p.hours.map(&:rate).uniq.to_sentence
              td number_to_currency(p.hours.map{|h| h.total_hours * h.rate.rate }.inject(:+))
              td current.strftime('%B %Y')
            end
          end
          current = current - 1.month
        end
      end
    end

  end

end