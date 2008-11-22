class TreebanksController < ApplicationController
    include REXML
    before_filter :login_required

 
  # GET /treebanks.xml
require 'cgi'
 
def documentChooser
  @documents = Documents.find(:all)
end

def renderSentenceHTML
  @sentenceTree = Treebank.find(:all, :order => "word_id", :conditions => "sentence='"+params[:sentence] + "' and user_id = '" + params[:user_id].to_s + "'")
  @sentenceTree.sort! { |a,b| a.word.number <=> b.word.number }
end

def dotPath
  #TODO include windows path, and make this an array or something more sensible
  macos_dot_path = "/usr/local/graphviz/bin/"
  linux_dot_path = "/usr/bin/"
  if FileTest.executable?(macos_dot_path + "dot") then
     return macos_dot_path
  else 
    if FileTest.executable?(linux_dot_path + "dot") then
      return linux_dot_path
    else
      return false
    end
  end
end

def renderSentenceSVG
   dot_location = dotPath()
 if !dot_location
   #don't really think I need this if I'm going to give the hard word in the svg below
   #flash[:error] = "The dot program is not at <pre>" + dot_location + "</pre>"
   @gvsvg= <<END
 <svg
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:cc="http://creativecommons.org/ns#"
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:svg="http://www.w3.org/2000/svg"
      xmlns="http://www.w3.org/2000/svg"
      xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
      xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
      width="744.09448819"
      height="1052.3622047"
      id="svg2"
      sodipodi:version="0.32"
      inkscape:version="0.46"
      sodipodi:docname="drawing.svg"
      inkscape:output_extension="org.inkscape.output.svg.inkscape">
     <defs
        id="defs4">
       <inkscape:perspective
          sodipodi:type="inkscape:persp3d"
          inkscape:vp_x="0 : 526.18109 : 1"
          inkscape:vp_y="0 : 1000 : 0"
          inkscape:vp_z="744.09448 : 526.18109 : 1"
          inkscape:persp3d-origin="372.04724 : 350.78739 : 1"
          id="perspective10" />
     </defs>
     <sodipodi:namedview
        id="base"
        pagecolor="#ffffff"
        bordercolor="#666666"
        borderopacity="1.0"
        gridtolerance="10000"
        guidetolerance="10"
        objecttolerance="10"
        inkscape:pageopacity="0.0"
        inkscape:pageshadow="2"
        inkscape:zoom="1.4"
        inkscape:cx="252.47368"
        inkscape:cy="845.99773"
        inkscape:document-units="px"
        inkscape:current-layer="layer1"
        showgrid="false"
        inkscape:window-width="691"
        inkscape:window-height="722"
        inkscape:window-x="342"
        inkscape:window-y="139" />
     <metadata
        id="metadata7">
       <rdf:RDF>
         <cc:Work
            rdf:about="">
           <dc:format>image/svg+xml</dc:format>
           <dc:type
              rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
         </cc:Work>
       </rdf:RDF>
     </metadata>
     <g
        inkscape:label="Layer 1"
        inkscape:groupmode="layer"
        id="layer1">
       <rect
          style="fill:#ffff00;stroke:#000000;stroke-opacity:1"
          id="rect3199"
          width="340.71429"
          height="189.28572"
          x="72.14286"
          y="43.790752" />
       <text
          xml:space="preserve"
          style="font-size:12px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:Serif;-inkscape-font-specification:Serif"
          x="82.85714"
          y="66.647896"
          id="text2383"><tspan
            sodipodi:role="line"
            x="82.85714"
            y="66.647896"
            id="tspan2387">Querci could not find graphviz 'dot' on the server.</tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="81.647896"
            id="tspan2391">Please ensure it is installed before proceeding.</tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="96.647896"
            id="tspan2395" /><tspan
            sodipodi:role="line"
            x="82.85714"
            y="111.6479"
            id="tspan2397" /><tspan
            sodipodi:role="line"
            x="82.85714"
            y="126.6479"
            id="tspan2399">Dot can be installed on an ubuntu/debian server with</tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="141.64789"
            id="tspan2401">the command 'sudo apt-get install graphviz'</tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="156.64789"
            id="tspan2403"></tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="171.64789"
            id="tspan2405">Builds of graphviz for MacOS are available as disk</tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="186.64789"
            id="tspan2407">images <a xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://www.ryandesign.com/graphviz/"><tspan font-weight="bold">here</tspan></a></tspan><tspan
            sodipodi:role="line"
            x="82.85714"
            y="201.64789"
            id="tspan2393" /></text>
     </g>
   </svg>
END
 else
 @sentenceTree = Treebank.find(:all, :order => "word_id", :conditions => "sentence='"+params[:sentence] + "' and user_id = '" + params[:user_id].to_s + "'")

#sort in sentence order so that the graph 'reads' from left to right
@sentenceTree.sort! { |a,b| a.word.number <=> b.word.number }

mystring= <<DOC
digraph G {size="5,3.5" node [fontname="Monaco", fontsize=8, margin="0.01, 0.01", color=blue, width=0.1, height=0.1]; node0[ label="this is a node with a very long name"]; node0 -> node1; node1 [style=filled]; node2 [style=filled, fillcolor=red]; node2 -> node0; }
DOC

dotDescription = <<DOC
 digraph G {size="9,5"  node [fontsize=8, fontname="Georgia", margin="0.005, 0.005", color=blue, width=0.1, height=0.1];
DOC
for treebank in @sentenceTree
  dotDescription +=  treebank.word_id.to_s + '[label="' + treebank.word.form + '", shape=plaintext]; ' + treebank.head_id.to_s + ' -> ' +  treebank.word_id.to_s  + '[label="' + treebank.relation + '", ' + 'fontname="Arial", labelfloat="true", arrowsize=".5", fontsize="6", fontcolor="#874C3B", color="gray"]; ' 
unless Treebank.exists?(:word_id => treebank.head_id, :user_id => params[:user_id]) 
  dotDescription += treebank.head_id.to_s + '[label="' + treebank.head_word.form + '", shape=plaintext, id="' + treebank.head_id.to_s + '"]; '
  end
end 
dotDescription += "}"
graphType = params[:graphType] || "dot"
dotCommand = dotPath() + "dot" + " -q -Tsvg "
gv=IO.popen(dotCommand,"w+")
gv.puts dotDescription #"digraph G{", mystring, " }" 
gv.close_write
@textOut = mystring
@gvsvg= gv.read
# Proper css disallows dimensionless numbers here;
# if we don't include a dimension, FF will default to something
# huge. Moreover, graphviz reads font size as *pixel*, not points.
@gvsvg.gsub!(/(font-size:\d+\.\d+)/,'\1px')
@gvsvg.gsub!(/.*(<svg.*<\/svg>).*/m,'\1')
parse_svg=REXML::Document.new(@gvsvg)
#the node id attributes provided by 'dot' are generic and cannot
#be used to manipulate with javascript
#the following replaces these with the word id number from the database,
#which has already been given to the 'title' element
parse_svg.root.each_element_with_attribute('class', 'graph') {|e|
  e.each_element_with_attribute('class', 'node') {|node|
     word_number = node.elements['title'].text
     node.attributes['id'] =  "SVG_" + word_number;
     #the following js calls have to be provided in the view
     node.attributes['onmouseover'] = "highlightText(" + word_number + ");"
     node.attributes['onmouseout'] = "deHighlightText(" + word_number + ");"
     node.attributes['onclick'] = "deleteFromSVG" + word_number + "();"
  }
}
@gvsvg = parse_svg.to_s
@svg_width=parse_svg.root.attributes["width"].gsub(/pt$/,'').to_i
@svg_height=parse_svg.root.attributes["height"].gsub(/pt$/,'').to_i
     respond_to do |format|
       format.html do
         render :layout => false
       end
  end
end
end

def listBankedWords
  bankedWordsInSentence = Treebank.find(:all, :conditions => "sentence='"+params[:sentence] + "' and user_id = '" + params[:user_id].to_s + "'")
  @list = ""
  for word in bankedWordsInSentence 
     @list += word.id
   end
   render :layout => false
 end
 
  def clearSentence
   render :layout => false
    Treebank.destroy_all "sentence='"+params[:sentence] + "'and user_id = '" + params[:user_id].to_s + "'"
     @message = "Deleted"
  end

  def renderSentence
    @sentenceTree = Treebank.find(:all, :order => "word_id", :conditions => "sentence='"+params[:sentence] + "' and user_id = '" + params[:user_id].to_s + "'")
     respond_to do |format|
       format.html do
         render :layout => false
       end
#       format.svg
     end
  end
  
  def deleteByWordId
    bank = Treebank.find_by_user_id_and_word_id(params[:user_id], params[:word_id])
    bank.destroy();
    renderSentenceSVG();
  end
  
  def addFromJS
  bank = Treebank.find_or_create_by_user_id_and_word_id(params[:user_id],  params[:word_id])
  # Head cannot be the object of anything
  if bank.word.number == 0 
   # flash.now[:error] = "Head is always the Head of another word"
    bank.destroy()
  else
   bank.relation = params[:relation]
   bank.head_id = params[:head_id]
   bank.sentence = params[:sentence]
   bank.save()
   # if the reverse relationship exists in the database, then delete it because it is not
   # possible for words to be in reciprocal relationship.
   reverse = Treebank.find_by_word_id_and_head_id(params[:head_id], params[:word_id])
    if reverse != nil 
      reverse.destroy()
    end
   end
   
         renderSentenceSVG() 
  end
  
  def addFromJSnew
     bank = Treebank.find_or_create_by_user_id_and_word_id(params[:user_id],  params[:word_id])
      bank.relation = params[:relation]
      bank.head_id = params[:head_id]
      bank.sentence = params[:sentence]
      bank.save()
   #HEAD cannot be the subject
   
   #Reciprocal relationships are not possilbe in these graphs. So if there exists a 
   #reverse relationship, we delete it.
   reverse = Treebank.find_by_word_id_and_head_id(params[:head_id], params[:word_id])
   if reverse != nil 
     reverse.destroy()
   end
       if bank.save
      renderSentenceSVG() 
     end
  end

  def index
   require "rexml/document"

    string = <<EOF
    <treebanks
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xmlns:treebank="http://nlp.perseus.tufts.edu/syntax/treebank/1.5"
    	xsi:schemaLocation="http://nlp.perseus.tufts.edu/syntax/treebank/1.5 treebank-1.5.xsd">
    	</treebanks>
EOF
    @treebanks_out = Document.new(string)
@treebanks_in = Treebank.find(:all, :order => "sentence, word_id")
 
 @treebanks_sort = @treebanks_in.sort_by{ |t| [ t.user_id, t.word.document_urn, t.word.sentence, t.word.number] }
 user = document = sentence = old_user_id = old_document_urn = old_sentence_number = nil
 @treebanks_sort.each { |t| 
   if old_user_id != t.user_id #initial case 
     old_user_id = t.user_id 
      user = Element.new "treebank"
      user.attributes["version"] = "1.5"
      annotator = user.add_element "annotator"
      annotatorShort = Element.new "short"
      annotatorShort.text = t.user.login
      annotator.add_element(annotatorShort)
      annotatorName = Element.new "name"
       annotatorName.text = t.user.name
       annotator.add_element(annotatorName)
       annotatorAddress = Element.new "address"
       annotatorAddress.text = t.user.address
       annotator.add_element(annotatorAddress)
      @treebanks_out.root.add_element(user)
       old_document_urn  = nil
       old_sentence_number = nil
   end
   if old_sentence_number != t.word.sentence
     old_sentence_number = t.word.sentence
     sentence = Element.new "sentence"
     sentence.attributes["id"] = t.word.sentence
     sentence.attributes["document_id"] = t.word.document_urn
     sentence.attributes["subdoc"] =t.word.span
     sentence.attributes["span"] = t.word.subdoc
     primary = sentence.add_element "primary"
     primary.text = t.user.login
     user.add_element(sentence)
   end
   

sentence.add_element "word", {"lemma" => "NOT_IN_THIS_VERSION", "postag" => "NOT_IN_THIS_VERSION", "id" => t.word.number, "form" => t.word.form, "head" => t.head_word.number, "relation" => t.relation}
 }
 #wrap up by appending the last of all of these
# document.add_element(sentence)
# user.add_element(document)
# @treebanks_out.root.add_element(user)
 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  #{ render :xml => @treebanks} 
    end
  end

    
  # GET /treebanks/1
  # GET /treebanks/1.xml
  def show
    @treebank = Treebank.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @treebank }
    end
  end

  # GET /treebanks/new
  # GET /treebanks/new.xml
  def new
    @treebank = Treebank.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @treebank }
    end
  end

  # GET /treebanks/1/edit
  def edit
    @treebank = Treebank.find(params[:id])
  end

  # POST /treebanks
  # POST /treebanks.xml
  def create
    @treebank = Treebank.new(params[:treebank])

    respond_to do |format|
      if @treebank.save
        flash[:notice] = 'Treebank was successfully created.'
        format.html { redirect_to(@treebank) }
        format.xml  { render :xml => @treebank, :status => :created, :location => @treebank }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @treebank.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /treebanks/1
  # PUT /treebanks/1.xml
  def update
    @treebank = Treebank.find(params[:id])

    respond_to do |format|
      if @treebank.update_attributes(params[:treebank])
        flash[:notice] = 'Treebank was successfully updated.'
        format.html { redirect_to(@treebank) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @treebank.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /treebanks/1
  # DELETE /treebanks/1.xml
  def destroy
    @treebank = Treebank.find(params[:id])
    @treebank.destroy

    respond_to do |format|
      format.html { redirect_to(treebanks_url) }
      format.xml  { head :ok }
    end
  end
end
