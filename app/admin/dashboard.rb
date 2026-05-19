# frozen_string_literal: true
require 'ostruct'

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1

  page_action :invoice, method: :get do
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date

    project = Project.find(params[:project_id])
    hours = project.hours.where(date: start_date..end_date).orderd

    html = render_to_string template: "/invoice/invoice", locals: { project: project, hours: hours, start_date: start_date, end_date: end_date }, layout: "pdf"

    return render html: html if params[:type] == "html"

    pdf = Grover.new(html, format: "A4", display_url: request.base_url).to_pdf
    send_data pdf, filename: "#{project}-#{start_date.to_s.parameterize}-#{end_date.to_s.parameterize}.pdf", type: "application/pdf"
  end

  page_action :cal_events, method: :get do
    pp params
    (start_date, end_date, _) = params.permit(:start, :end, "_").values
    hours = Hour
      .where(date: start_date...end_date)
      .includes(project: :client)
      .all
      .group_by(&:date)
      .map do |_date, hours|
      start_time = 9
      hours.map do |hour|
        my_start = start_time
        start_time += hour.total_hours
        {
          id: hour.id,
          title: hour.project.to_s,
          allDay: false,
          start: (hour.date.to_time + my_start.hours).iso8601,
          end: (hour.date.to_time + start_time.hours).iso8601,
          url: "/admin/hours/#{hour.id}/edit",
          className: hour.project.client.name.parameterize,
        }
      end
    end
      .flatten

    return render json: hours
  end

  controller do
    before_action :set_filter

    def set_filter
      @filter = OpenStruct.new(start: (Date.today - 2.months).at_beginning_of_month, end: Date.today.at_end_of_month, client_id: nil, project_id: nil)

      if params[:filter].present?
        p = params.require(:filter).permit(:start, :end, :client_id, :project_id)
        @filter.start = Date.parse(p[:start])
        @filter.end = Date.parse(p[:end])
        @filter.client_id = p[:client_id].presence
        @filter.project_id = p[:project_id].presence
      end
    end
  end

  sidebar :date_filter do
    render partial: "date_filter"
  end

  content do
    panel "Week view" do
      render partial: "calendar"
    end

    @filter = OpenStruct.new(start: (Date.today - 2.months).at_beginning_of_month, end: Date.today.at_end_of_month, client_id: nil, project_id: nil)

    if params[:filter].present?
      p = params.require(:filter).permit(:start, :end, :client_id, :project_id)
      @filter.start = Date.parse(p[:start])
      @filter.end = Date.parse(p[:end])
      @filter.client_id = p[:client_id].presence
      @filter.project_id = p[:project_id].presence
    end

    hours = Hour.where(date: @filter.start..@filter.end)
    hours = hours.joins(project: :client).where(clients: { id: @filter.client_id }) if @filter.client_id
    hours = hours.where(project_id: @filter.project_id) if @filter.project_id

    current = Time.now
    first = hours.minimum(:date)&.at_beginning_of_month

    while first && current >= first
      month_total = 0.0

      table class: "index_table index dashboard" do
        thead do
          tr do
            th "Client"
            th "Project"
            th do
              raw content_tag(:div, '<span>Hours</span><span>Budget</span>'.html_safe, style: 'display:flex;justify-content:space-between;align-items:center;gap:12px;')
            end
            th "Rate"
            th "Total"
            th ""
          end
        end
        tbody do
          i = 0
          month_hours = Hour.where(date: current.at_beginning_of_month..current.at_end_of_month)
          month_hours = month_hours.joins(project: :client).where(clients: { id: @filter.client_id }) if @filter.client_id
          month_hours = month_hours.where(project_id: @filter.project_id) if @filter.project_id
          project_ids = month_hours.select(:project_id).distinct.pluck(:project_id)
          Project.includes(:client).where(id: project_ids).accessible_by(current_ability).order("clients.name").order(:name).each do |p|
            tr class: (i.odd? ? "even" : "odd") do
              start_date = current.at_beginning_of_month >= @filter.start ? current.at_beginning_of_month : @filter.start
              end_date = current.at_end_of_month <= @filter.end ? current.at_end_of_month : @filter.end
              hours = p.hours.includes(:rate).where(date: start_date..end_date)
              project_total = hours.map { |h| h.total_hours * h.rate.rate }.inject(:+)
              month_total += project_total

              td p.client
              # td "#{start_date.to_date} - #{end_date.to_date}"
              td p.name
              td do
                month_hours_total = hours.sum(:total_hours)
                month_sno_total = hours.sum(:total_sno_hours)
                left_parts = [month_hours_total.to_s]
                left_parts << content_tag(:span, "#{month_sno_total} S&O", style: 'color:#6b7280;margin-left:8px;') if month_sno_total.to_f.positive?
                right = ''
                if p.budget? && p.budget_hours&.positive?
                  spent_to_date = p.spent_amount(up_to: end_date)
                  used_hours = p.default_rate_amount&.positive? ? (spent_to_date / p.default_rate_amount) : nil
                  budget_hours = p.budget_hours
                  if used_hours
                    pct = (used_hours / budget_hours * 100).round
                    over = used_hours > budget_hours
                    style = over ? 'color:#b91c1c;font-weight:600;' : 'color:#6b7280;'
                    right = content_tag(:span, "(#{pct}% - #{used_hours.round(1)}/#{budget_hours.round(1)})", style: style)
                  end
                end
                raw content_tag(:div, raw(left_parts.join(' ')) + raw(right), style: 'display:flex;justify-content:space-between;align-items:center;gap:12px;')
              end
              td hours.map(&:rate).uniq.to_sentence
              td number_to_currency(project_total)
              td link_to(
                   icon("fas", "file-pdf"),
                   admin_dashboard_invoice_path(project_id: p.id, end_date: end_date.to_date, start_date: start_date.to_date, type: :pdf)
                 ) + " - " +
                 link_to(icon("far", "eye"), admin_dashboard_invoice_path(project_id: p.id, end_date: end_date.to_date, start_date: start_date.to_date, type: :html))
              i += 1
            end
          end
        end

        h2 do
          span class: "date" do
            current.strftime("%B %Y")
          end
          span class: "total" do
            number_to_currency(month_total)
          end
        end
      end

      current -= 1.month
    end
  end
end
