module ParticipantsHelper
  def calendar_link_qr_code(url, size: 200)
    return nil if url.blank?

    qrcode = RQRCode::QRCode.new(url)
    qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      use_path: true,
      viewbox: true,
      svg_attributes: {
        width: "100%",
        height: "100%",
        class: "w-full h-full"
      }
    ).html_safe
  end
end
