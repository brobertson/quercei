class SentenceController < ApplicationController
 before_filter :login_required

def index
 @tagset = ["PRED", "SBJ", "OBJ", "ATR", "ADV", "ATV/AtvV", "PNOM", "OCOMP", "COORD", "APOS", "AuxP", "AuxC", "AuxR", "AuxY", "AuxX", "AuxG", "AuxK", "AuxV", "AuxZ", "ExD", "PRED_CO", "SBJ_CO", "OBJ_CO", "ATR_CO", "ADV_CO", "ATV/AtvV_CO", "PNOM_CO", "OCOMP_CO", "ADV_AP", "ATR_AP", "COORD_AP", "OBJ_AP"] 
 @graphTypes = ["dot", "neato"]
  @document_urn = params[:document_urn]
  @subdoc = params[:subdoc]
  if  params[:sentence] == "0" 
   @sentence_number = Word.first(:all, :order => "sentence", :conditions => ["document_urn = ? and subdoc = ?", @document_urn, @subdoc]).sentence   
  
  else  
    @sentence_number = params[:sentence]
  end
  @next_sentence_number = 1 + @sentence_number.to_i
  @previous_sentence_number = @sentence_number.to_i - 1 
  @words = Word.find(:all, :order => "number", :conditions => ["document_urn = ? and sentence = ? and subdoc = ?", @document_urn, @sentence_number, @subdoc])
  @next_sentence_exists = Word.exists?(["document_urn = ? and sentence = ? and subdoc = ?", @document_urn, @next_sentence_number, @subdoc])
  @previous_sentence_exists = Word.exists?(["document_urn = ? and sentence = ? and subdoc = ?", @document_urn, @previous_sentence_number, @subdoc])
end
end
