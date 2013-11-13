function drawBackButton(parent)
{
    var header = jQuery("h1");
    if (parent!=""){
        header.append(" <a href='"+rootContextPath+parent+"' id='upButton'>Up</a>");

    }

}