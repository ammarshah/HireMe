class InterviewsController < ApplicationController
  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @interviews }
    end
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
    @interview = Interview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @interview }
    end
  end

  # PUT /students/:id/interview/new
  def new
    @interview = Interview.new

    if params[:student_id]
      @student = Student.find(params[:student_id])
    elsif params[:job_id]
      @job = Job.find(params[:job_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interview }
    end
  end

  # GET /interviews/1/edit
  def edit
    @interview = Interview.find(params[:id])
  end

  # POST /students/:id/interview/
  def create    
    @interview = Interview.new(params[:interview])

    if params[:student_id]
      @student = Student.find(params[:student_id])
    elsif params[:job_id]
      @job = Job.find(params[:job_id])
    end
    
    respond_to do |format|
      if @interview.save
        if @student
          format.html { redirect_to @student, notice: 'Interview was successfully created.' }
          format.json { render json: @student, status: :created, location: @interview }
        elsif @job
          format.html { redirect_to @job, notice: 'Interview was successfully created.' }
          format.json { render json: @job, status: :created, location: @interview }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /interviews/1
  # PUT /interviews/1.json
  def update
    @interview = Interview.find(params[:id])

    respond_to do |format|
      if @interview.update_attributes(params[:interview])
        format.html { redirect_to @interview, notice: 'Interview was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview = Interview.find(params[:id])
    @interview.destroy

    respond_to do |format|
      format.html { redirect_to interviews_url }
      format.json { head :no_content }
    end
  end
end
