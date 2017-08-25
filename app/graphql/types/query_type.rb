QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "Root query entry"

  ################################
  ## Clients
  #

  field :client, ClientType, "Get client by id" do 
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { Client.find(args["id"]) }
  end

  field :clients, types[ClientType], "List all clients" do 
    resolve -> (obj, args, ctx) { Client.all }
  end

  ################################
  ## Hours
  #

  field :hour, HourType, "Get hours by id" do 
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { Hour.find(args["id"]) }
  end
  
  field :hours, types[HourType], "List all hours" do 
    resolve -> (obj, args, ctx) { Hour.all }
  end
  
  ################################
  ## Projects
  #

  field :project, ProjectType, "Get project by id" do 
    argument :id, !types.ID 
    resolve -> (obj, args, ctx) { Project.find(args["id"]) }
  end

  field :projects, types[ProjectType], "List all projects" do 
    argument :limit, types.Int
    resolve -> (obj, args, ctx) { 
      p = Project.all 
      p = p.limit(args[:limit]) if args[:limit].present?
      p
    }
  end
  
end
