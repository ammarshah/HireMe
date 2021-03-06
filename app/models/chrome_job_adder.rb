class ChromeJobAdder

	attr_accessor :scraper, :url

	def initialize(url)
		@url 		 = url
		@scraper = JobScraper.determine_scraper(@url)
	end

	# Scrape job information from given link.
	def scrape_job
		scraper.scrape
	end

	# Find or creates company based on name provided.
	def find_or_create_company
		company_name = scraper.company_name
		company_name = scraper.crunchbase_name if scraper.crunchbase_name
		company 		 = Company.find_by_name(company_name)

		if company
			@company = company
		else
			company_name.gsub!(' ', '-')
			@company  = CompanyScraper.new(company_name).create_company
		end
	end

	# Associates company to job.
	def create_and_associate_job
		if @scraper.job_title
			@job = @company.jobs.build(
				:title => @scraper.job_title,
				:description => @scraper.description
			)
		end
		@company.save
	end

	# Method that finds and associates company to job.
	def create_job_from_link
		scrape_job
		find_or_create_company
		create_and_associate_job

		@job
	end

end
