Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '20px',
      bottom: '20px',
      left: '20px',
      right: '20px'
    },
    print_background: true,
    prefer_css_page_size: false,
    launch_args: ['--no-sandbox', '--disable-setuid-sandbox'],
    executable_path: ENV['PUPPETEER_EXECUTABLE_PATH']
  }
end
