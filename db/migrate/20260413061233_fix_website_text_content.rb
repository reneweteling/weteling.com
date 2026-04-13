class FixWebsiteTextContent < ActiveRecord::Migration[8.0]
  def up
    # Fix CV page content
    fix_cv_content

    # Fix project descriptions (site-facing)
    fix_project_descriptions

    # Fix CV project descriptions
    fix_cv_project_descriptions
  end

  def down
    # Content fixes are not reversible in a meaningful way
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def fix_cv_content
    page = Page.find_by(pagetype: :cv)
    return unless page

    page.update!(
      content_en: cv_content_en,
      content_nl: cv_content_nl
    )
  end

  def fix_project_descriptions
    # Odido / T-Mobile (id:30)
    update_project(30,
      description_about_the_company: "Odido, formerly known as T-Mobile, has a digital realm that extends beyond what meets the eye. As a developer in the company, I have the opportunity to think like an architect, considering responsibilities, data storage, and optimal placement. It's an engaging and enriching experience.",
    )

    # DPG (id:28)
    update_project(28,
      description_about_the_company: "MyChannels is a division within DPG Media group that is responsible for all digital content on all digital outlets of DPG. Ad.nl, Volkskrant.nl, Hln.be, Trouw.nl, Parool.nl and so on.\nThe team is compact, senior and knowledgeable. We are responsible for more than 5 million video plays each day. Creating services to supply the media outlets with videos, games and entertainment. Providing the mobile API for the apps of the papers. And so on. \n\nMore about [DPG](https://www.dpgmedia.nl/) and [MyChannels](https://mychannels.com/)",
      description_my_role: "As a full-stack developer I've worked on the backend, mainly in Phoenix and Ruby on Rails, created new interfaces inside of the videoplayer using React, Svelte and Typescript. Changed styling for new brands. Added schema changes. In the last 6 months my focus was on infrastructure, moving from manually created infra to Terraform, implementing security best practices and making the whole infra more robust and flexible.",
    )

    # Re:turnista (id:25)
    update_project(25,
      description_my_role: "As a full-stack dev, I was tasked to give the current architecture some love to make it more performant. We removed all the custom form logic and implemented a package called Formik, changed the event structure to work more with reducers. Overall cleanup and modularizing of the system.",
    )

    # Zwitserleven (id:26)
    update_project(26,
      description_about_the_company: "Vivat is the mother company of Zwitserleven. Vivat has a \"My\" environment where clients can log in and see information about their products. My team was responsible for the Pension funnel.\n\nMore about [zwitserleven](https://www.zwitserleven.nl) and [The Main Ingredient](https://themainingredient.co/)",
      description_my_role: "As a front-end developer, I changed the loading system (basically the system contained multiple systems so a dynamic loader was needed, especially with varying backend services). Created small updates, and fixed some tickets.",
    )

    # DigiB (id:27)
    update_project(27,
      description_about_the_company: "DigiB is a division of Brenntag. Brenntag is market leader in the supply of raw chemicals. DigiB is tasked with the digital transformation of Brenntag by bringing an e-commerce system, internal trading and couplings between all offices. \n\nMore about [DigiB](https://digib.com/)",
      description_my_role: "As a front-end developer I've worked with the front-end team to expand the e-commerce system built in React, with Next.js and a Node.js middleware. I've also been working on the \"target architecture\", an overcoupling system that is able to connect multiple ERP systems like Oracle, SAP, Salesforce etc. This design was Reactive using a message bus.",
    )

    # Ace & Tate (id:20)
    update_project(20,
      description_my_role: "As a full-stack dev, I was tasked to optimize and add features to the Solidus powered Ruby on Rails backend. For the consumer and POS facing this was mostly an API. For the internals there was an Admin section and for the internal Friends and Family there was a complete suite with admin panel implemented. I helped maintain over 30 gems, used Elastic Beanstalk for running the app, and increased the test coverage overall.",
    )

    # Tankey (id:19)
    update_project(19,
      description_about_the_company: "Tankey is a loyalty platform (LP) created by Essent for their other brand EnergieDirect. The first version of the LP was built within Essent. Meaning that linking other companies proved to be difficult, that's why they split up Tankey from Essent and started building a new and better version of the app.\n\nMore info about [Tankey](https://www.energiedirect.nl/apps/tankey)",
      description_my_role: "As a backend developer I was tasked to build an API for the Tankey Android app, build an admin interface where the business can see KPIs, create exports and get the correct insights in what the app is doing. Build a stable and auditable system concerning the new GDPR ruling. Create API couplings between Firebase for in-app notifications. Create a discount calculator module. And integrate loyalty partners through our API.",
    )

    # Abn Amro (id:18)
    update_project(18,
      description_about_the_company: "The Main Ingredient was tasked to help out the CyberSecurity department of ABN Amro with creating more awareness for cyber threats for small companies. Think of phishing emails, certain new techniques that they have spotted or even social engineering. TMI came up with Veiligzondermoeite.nl, an initiative to inform the general public.\n\nMore about [Veiligzondermoeite](https://www.veiligzondermoeite.nl/) and [TMI](https://themainingredient.co/)",
      description_my_role: "As a full-stack developer, I was asked to lead a team of highly skilled developers and designers to create in just 6 weeks a working POC of the app. The app was built in ReactNative, the backend in Node.js using Express as server layer and deployed on BeanStalk using a CloudFormation template. We also hooked up an RDS instance for our persistence. My main focus was in creating the backend and helping out with the ReactNative app. The team was excellent in styling / creating components, my assistance was most needed in hooking up the APIs.",
    )
  end

  def fix_cv_project_descriptions
    # HalloRoos (id:10)
    update_project(10,
      description_cv: "[HalloRoos](https://halloroos.nl/) is a contract alarm platform where users can set alarms for contracts that will expire in the future so that they can switch providers on time. HalloRoos was looking to extend their functionality and needed a developer to help them reach their goals. The subject itself is somewhat sensitive, but it comes down to a pretty selection then order flow with a lot of validations and constraints. Each step is communicated to an API provided to store and manage the data.\n\nMy role in this project:\n\n*   Build the pages as described in Rails using Slim, Sass, and CoffeeScript\n*   Connect the pages to virtual models so that we can apply validations \n*   Persist the validated models to the provided API",
    )

    # Van Ons (id:3)
    update_project(3,
      description_cv: "[Van Ons](https://www.van-ons.nl/) is a really cool WP design agency based in Amsterdam. For some projects, they contract out for special features and this was quite special. They wanted to create a web interface where clients can cut out a portion of a really big image (30 by 30 meters at 76dpi approx 46GB per image). So I've developed a React frontend where the users can walk through the image using DeepZoom. And cut out a shape and then sending the coordinates to a worker server, cutting out the piece and mailing it to a carpet printer. Pretty heavy stuff. \n\nYou must know that an image bigger than 4GB isn't even supported in Windows, and it's pretty big for Mac and Unix standards too. So what we did is cut the image into 80 pieces, then on the server only assemble the parts that we need to keep the overall size down. I've hit a lot of problems along the way. First, we started out with ImageMagick. It turns out that ImageMagick is single-threaded so our monster server wasn't doing anything. Then we moved to different C libraries and finally hit the sweet spot with OpenCV and LibVips. Generating a preview over a canvas more than 5,000,000 pixels in just 4 seconds and creating the final product at high DPI.\n\nEverything was new, everything was exciting, it was an awesome project. The final version is visible here at [Skonne](https://www.skonne.com/app/#/)",
    )

    # Revolve Music (id:2)
    update_project(2,
      description_cv: "[Revolve Music](https://www.revolve-music.com/) is a SAAS platform where users (Artists mostly) can create a website, a digital presence in just a few minutes. Connecting to filled content providers like SoundCloud, BandsInTown, LinkedIn, Twitter etc your site is filled with content and you are ready to go.\n\nMy role in this project:\n\n*   Clean up and rebuild existing code (the overall quality was very poor and not very robust)\n*   Create a Continuous integration environment using CircleCi and AWS container service\n*   Creating a global scaling webserver setup using: Route53, AWS EC2, AWS EC2 container service, Cloudfront, RDS, S3 and Docker\n*   Being responsible for the Technical day2day, building team culture, applying standards, laying out technical roadmaps etc. CTO stuff.",
    )

    # Horyon (id:1)
    update_project(1,
      description_cv: "Horyon innovaties B.V. is an asbestos removal company. Asbestos has a bad reputation and that's why there is a lot of legislation. They are required to have all data on premise at all times. This is just not possible on paper, so we have created a Rails backend with a RESTful API connecting a Cordova Android app. The app started out as a simple hour measuring platform, but now it has over 18 main functions and one of them is drawing on a photographed map. \n\nMy role in this project:\n\n*   Clean up and rebuild existing code (the overall quality was very poor and not very robust)\n*   Create a Continuous integration environment using CircleCi and AWS container service\n*   Creating a global scaling webserver setup using: Route53, AWS EC2, AWS EC2 container service, Cloudfront, RDS, S3 and Docker\n*   Being responsible for the Technical day2day, building team culture, applying standards, laying out technical roadmaps etc. CTO stuff.",
    )
  end

  def update_project(id, attributes)
    project = Project.find_by(id: id)
    return unless project
    project.update!(attributes)
  end

  def cv_content_en
    <<~MARKDOWN
      # CV - Ren&eacute; Weteling
      *Freelance | Tech lead | Fractional CTO | Problem solver | Full-Stack development*

      <div class="personal-info"></div>
      - **Name**
      \tRen&eacute; Weteling
      - **Home address**
      \tJohannes Geradtsweg 47, 1222PM Hilversum
      - **Phone number**
      \t[+316 (0) 55 128 199](tel:0031655128199)
      - **Portfolio**
      \t[www.weteling.com](https://www.weteling.com)
      - **E-mail address**
      \t[rene@weteling.com](mailto:rene@weteling.com "rene@weteling.com")
      - **Date of birth**
      \t04-12-1986
      - **Birthplace & nationality**
      \tCapelle a/d IJssel, Dutch


      ### About me

      Tech has always been my passion, tracing back to my earliest memories of tinkering with gadgets and diving into computers. This enthusiasm drove me to pursue a bachelor's degree in IT sciences, which laid a strong foundation for my professional journey.

      My career began at a design agency, where I collaborated with companies of various sizes, gaining diverse experience. Transitioning to freelance work allowed me to deliver optimal value to my clients, a role that invigorates and fulfills me.

      I excel in building greenfield applications efficiently, from selecting the best development techniques to architecting the target infrastructure. By prioritizing automation, I ensure a seamless coding experience, leading to better project outcomes. Happy developers produce superior code quality.

      I thrive on sharing my expertise with teams and organizations, enjoying their growth and success. Colleagues often describe me as a sociable hard worker with a keen sense of humor and a results-oriented mindset.

      ### Skills & Knowledge

      Here are the most pertinent highlights of my skill set:

      - **Languages & Frameworks**
        - Dutch native proficiency
        - English bilingual proficiency
        - Elixir (Phoenix)
        - Ruby (Ruby on Rails, Sinatra)
        - Javascript (ES6, Typescript)
        - Python (mainly hobby projects, no production work as of yet)
        - Front-end frameworks (VueJs, Pinia, Ionic, React, Turbo, Stimulus)
        - Databases (MySQL, PostgreSQL, SQLite, MSSql)
        - Message queues (Kafka, RabbitMQ, Redis)
        - NoSQL databases (MongoDB, PouchDb, DynamoDB, Redis, ElasticSearch)
        - Styling (Sass, Scss, Less, Css)
        - Git flavors (Github, Bitbucket, Gitlab, Azure DevOps)
        - Project management (Scrum, Agile, Clubhouse, Flow, Asana, ClickUp, Jira, Azure DevOps, etc.)
      - **DevOps**
        - Terraform (AWS-flavor)
        - Hosting platforms (Heroku, Dokku, Docker, AWS, K8s, GCloud, Azure)
        - AWS (Fargate, S3, Route53, Beanstalk, EC2, RDS, ECR, etc.)
        - CI/CD (Github Actions, Gitlab, CircleCi, Travis)
      - **Architecture and design principles**
        - C4 model architecture design
        - Reactive programming
        - Distributed high load applications

      ## Education

      - #### The Coding Gnome
      \t2019 **Elixir for programmers**

      - #### Bureau Spraakwater
      \t2018 **Course public speaking**

      - #### Hogeschool Rotterdam
      \t2004 - 2010 **Bsc, ICT**

      - #### IJsselcollege
      \t1999 - 2004 **Havo, Natuur en Techniek**

      ## Work, projects and experiences
      &nbsp;
      [[projects]]
    MARKDOWN
  end

  def cv_content_nl
    <<~MARKDOWN
      # CV - Ren&eacute; Weteling
      *Freelance | Tech lead | Fractional CTO | Problem solver | Full-Stack development*

      <div class="personal-info"></div>
      - **Naam**
      \tRen&eacute; Weteling
      - **Adres**
      \tJohannes Geradtsweg 47, 1222PM Hilversum
      - **Telefoonnummer**
      \t[+316 (0) 55 128 199](tel:0031655128199)
      - **Portfolio**
      \t[www.weteling.com](https://www.weteling.com)
      - **E-mailadres**
      \t[rene@weteling.com](mailto:rene@weteling.com "rene@weteling.com")
      - **Geboortedatum**
      \t04-12-1986
      - **Geboorteplaats**
      \tCapelle a/d IJssel
      - **Nationaliteit**
      \tNederlands


      ### Over mij

      Van jongs af aan ben ik altijd geïnteresseerd geweest in computers, scripting en automatiseren. Dit begon toen ik klein was met het maken van menu's in MS-Dos, gevolgd door zakgeldberekeningen in Works Sheets, en later het bouwen van een digitaal roostersysteem voor de pizzeria waar ik werkte toen ik 16 was. Logischerwijs heb ik dit pad voortgezet en ben informatica gaan studeren, waarna ik bij een design agency terechtkwam.

      Het leuke aan het werken bij een design agency is dat je projectmatig werkt en met veel verschillende aspecten van IT in aanraking komt. Dit voedt mijn brede interesse: van teamdynamiek en programmeren tot devops en advies; ik doe het allemaal graag.

      Maar de echte sprong in mijn ontwikkeling kwam toen ik ben gaan freelancen. De verantwoordelijkheid die je voelt voor een project zorgt ervoor dat je scherp bent en wilt presteren. En deze mindset is uniform voor freelancers, je pusht elkaar echt naar een hoger niveau.

      ### Vaardigheden & Kennis

      Hier heb ik mijn meest prominente vaardigheden uitgeschreven.

      - **Talen & Frameworks**
        - De Nederlandse taal
        - De Engelse taal
        - Elixir (Phoenix)
        - Ruby (Ruby on Rails, Sinatra)
        - Javascript (ES6, Typescript)
        - Python (vooral nog hobby, maar zou er graag meer mee doen)
        - Front-end frameworks (VueJs, Pinia, Ionic, React, Turbo, Stimulus)
        - Databases (MySQL, PostgreSQL, SQLite, MSSql)
        - Message queues (Kafka, RabbitMQ, Redis)
        - NoSQL databases (MongoDB, PouchDb, DynamoDB, Redis, ElasticSearch)
        - Styling (Sass, Scss, Less, Css)
        - Git flavors (Github, Bitbucket, Gitlab, Azure DevOps)
        - Projectmanagement (Scrum, Agile, Clubhouse, Flow, Asana, ClickUp, Jira, Azure DevOps, etc.)
      - **DevOps**
        - Terraform (AWS-flavor)
        - Hosting platforms (Heroku, Dokku, Docker, AWS, K8s, GCloud, Azure)
        - AWS (Fargate, S3, Route53, Beanstalk, EC2, RDS, ECR, etc.)
        - CI/CD (Github Actions, Gitlab, CircleCi, Travis)
      - **Architectuur en ontwerpprincipes**
        - C4 model architectuurontwerp
        - Reactive programming
        - Gedistribueerde high-load applicaties

      ## Educatie

      - #### The Coding Gnome
      \t2019 **Elixir for programmers**

      - #### Bureau Spraakwater
      \t2018 **Cursus spreken in het openbaar**

      - #### Hogeschool Rotterdam
      \t2004 - 2010 **Bsc, ICT**

      - #### IJsselcollege
      \t1999 - 2004 **Havo, Natuur en Techniek**

      ## Werk, projecten en ervaringen
      &nbsp;
      [[projects]]
    MARKDOWN
  end
end
