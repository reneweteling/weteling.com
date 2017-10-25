namespace :slack do 

  task :dropfiles do

    # client_id = '2322332576.246809699152'
    # client_secret = '4a8d8dcb50e0214e606cd4009b3bfba5'
    # verify_token = 'rP843Ia1OmrVk1X0JRSQ3Wde'

    # cmd = "curl -s -L \"https://slack.com/oauth/authorize?#{{client_id: client_id, scope: 'files:write:user', redirect_uri: 'http://secure.weteling.com/slack'}.to_query}\""

    # pp cmd
    # auth = run_slack_cmd(cmd)

    # # get files
    # cmd = "curl -s -X POST --data '#{{client_id: client_id, client_secret: client_secret}.to_query}' https://slack.com/api/oauth.access"
    # auth = run_slack_cmd(cmd)
    # pp auth

    # binding.pry
  

    token = 'xoxp-2322332576-2378365022-246813365392-8ad00243838365f56b65df1487f4c9d9' # h&f
    
    # get upser id
    user_id = 'U02B4AR0N'
    
    # get files
    cmd = "curl -s -X POST --data '#{{token: token, count: 1000, user: user_id}.to_query}' https://slack.com/api/files.list"
    files = run_slack_cmd(cmd)['files']

    pp files.count

    # delete files older than 2 months
    files.each do |f|
      if Time.at(f['created']) < Date.today - 2.months
        data = {
          token: token, 
          file: f['id']
        }
        cmd = "curl -s -X POST --data '#{data.to_query}' https://slack.com/api/files.delete"
        pp run_slack_cmd(cmd)
      end
    end

  end

  def run_slack_cmd cmd
    JSON.parse(`#{cmd}`)
  end

end