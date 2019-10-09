class HeroesController < ApplicationController
  before_action :set_hero, only: [:show, :edit, :update, :destroy, :deploy]

  # GET /heroes
  # GET /heroes.json
  def index
    @heroes = Hero.all
  end

  # GET /heroes/1
  # GET /heroes/1.json
  def show
  end

  # GET /heroes/new
  def new
    @hero = Hero.new
  end

  # GET /heroes/1/edit
  def edit
  end

  # POST /heroes
  # POST /heroes.json
  def create
    @hero = Hero.new(hero_params)

    respond_to do |format|
      if @hero.save
        format.html { redirect_to @hero, notice: 'Hero was successfully created.' }
        format.json { render :show, status: :created, location: @hero }
      else
        format.html { render :new }
        format.json { render json: @hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heroes/1
  # PATCH/PUT /heroes/1.json
  def update
    respond_to do |format|
      if kv_group_evidences_params['name'] && @kv_group
        @kv_group.update(kv_group_evidences_params)
      end
      if plain_text_evidence_params['title'] && @plain_text_evidence
        @plain_text_evidence.update(plain_text_evidence_params)
      end
      if url_evidence_params['value'] && @url_evidence
        @url_evidence.update(url_evidence_params)
      end
      if @hero.update(hero_params)
        format.html { redirect_to @hero, notice: 'Hero was successfully updated.' }
        format.json { render :show, status: :ok, location: @hero }
      else
        format.html { render :edit }
        format.json { render json: @hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heroes/1
  # DELETE /heroes/1.json
  def destroy
    @hero.destroy
    respond_to do |format|
      format.html { redirect_to heroes_url, notice: 'Hero was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deploy
    NetRelated::ApiRequests.new.issue_badge(@hero.recipient_email, @hero.badge_template_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Hero.find(params[:id])
      @plain_text_evidence = PlainTextEvidence.where(hero_id: params[:id]).first
      @url_evidence = UrlEvidence.where(hero_id: params[:id])&.first
      @kv_group = KvGroupEvidence.where(hero_id: params[:id])&.first
      @kv_params = KvPairEvidence.where(kv_group_evidence_id: @kv_group&.id)&.first if @kv_group
    end

    def kv_group_evidences_params
      params.require(:kv_group_evidences).permit(:name)
    end

    def kv_pair_evidences_params
      params.require(:kv_pair_evidences_params).permit(:key, :value, :url)
    end

    def plain_text_evidence_params
      params.require(:plain_text_evidences).permit(:title, :description)
    end

    def url_evidence_params
      params.require(:url_evidences).permit(:value, :name, :description)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def hero_params
      params.require(:hero).permit(:recipient_email, :first_name, :last_name, :badge_template_id, :issued_at, :issuer_earner_id, :locale, :suppress_badge_notification_email, :expires_at, :country_name, :state_or_province)
    end
end
