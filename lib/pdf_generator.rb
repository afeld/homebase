module PdfGenerator
  def create_pdf(building)
    Prawn::Document.generate(Rails.root.join('tmp', "building-#{building.id}.pdf"), 
                                        :margin => 90, 
                                        :template => "images/template.pdf") do
    font "Helvetica"
    font_size 24
    text building.address, :color => "FF00FF"
    move_down 260
    text "\'join #{building.name}\' to #{TEL_NUMBER}", :align => :center
    end
  end
  
end