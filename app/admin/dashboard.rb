ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  
  content do
    current = Time.now
    first = Hour.minimum(:date)
    while current >= first do

      h2 current.strftime('%B %Y')

      table class: 'index_table index' do 
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
          Project.includes(:client, :hours => [:rate]).where(id, project_ids).orderd.find_each do |p|
            tr class: (i%2 == 1 ? 'even' : 'odd') do 
              td p.client 
              td p.name
              td p.hours.sum(:total_hours)
              td p.hours.map(&:rate).uniq.to_sentence
              td number_to_currency(p.hours.map{|h| h.total_hours * h.rate.rate }.inject(:+))
              td 'download'
              i += 1
            end
          end
          
        end
      end
      current = current - 1.month
    end

  end
end