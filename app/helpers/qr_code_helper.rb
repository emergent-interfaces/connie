module QrCodeHelper
  def qr_image_for(url,width=300, height=300)
    src_url = "https://chart.googleapis.com/chart"
    src_url << "?cht=qr"
    src_url << "&chs=#{width}x#{height}"
    src_url << "&chl=#{url}"
    src_url << "&chld=H"

    image_tag(src_url)
  end
end