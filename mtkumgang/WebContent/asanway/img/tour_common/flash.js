/*
###########�÷��� �ִ� �Լ�############
f_id = �÷��� ���̵�
f_name = �÷��� ���ϸ�
f_width = ����ũ��
f_height = ���γ���
f_trans = ����, transparent(����)
f_para = �Ķ����
*/
function show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para){
	document.write("<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-44455354000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+f_width+"' height='"+f_height+"' id='"+f_id+"'>");
	document.write("<param name='allowScriptAccess' value='always'/>");
	document.write("<param name='movie' value='"+f_name+"'>");
	document.write("<param name='quality' value='high'>");
	document.write("<param name='scale' value='noscale'>");
	document.write("<param name='wmode' value='"+f_trans+"'>");
	document.write("<PARAM NAME='flashvars' VALUE='"+f_para+"'>");
	document.write("<embed src='"+f_name+"' allowScriptAccess='always' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+f_width+"' height='"+f_height+"'></embed>");
	document.write("</object>");
}

function writeObject(obj_file,width,height,wmode)
{
    var obj_src = "";
    obj_src += "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\" width=\""+width+"\" height=\""+height+"\">\n";
    obj_src += "  <param name=\"movie\" value=\""+obj_file+"\">\n";
    obj_src += "  <param name=\"wmode\" value=\""+wmode+"\">\n";
    obj_src += "  <param name=\"menu\" value=\"false\">\n";
    obj_src += "  <param name=\"quality\" value=\"high\">\n";
    obj_src += "  <embed src=\""+obj_file+"\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\""+width+"\" height=\""+height+"\"></embed>\n";
    obj_src += "</object>\n";
    
    document.write(obj_src);
}


/*
############������ �ִ� �Լ�############
m_id = ������ id
m_width = ����ũ��
m_height = ���γ���
m_filename = ���ϸ�
m_control = ��Ʈ�� ���Ӽ��� (true, false)
m_start = �ڵ��÷��� ���� (true, false)
m_transparent = ������ ("",transparent)
*/
function show_movie_F(m_id,m_width,m_height,m_filename,m_control,m_start,m_transparent){
	document.write("<OBJECT CLASSID='clsid:22d6f312-b0f6-11d0-94ab-0080c74c7e95' ID='"+m_id+"' width='"+m_width+"' height='"+m_height+"'>");
	document.write("<PARAM NAME='filename' VALUE='"+m_filename+"'>");
	document.write("<PARAM NAME='ShowControls' VALUE='"+m_control+"'>");
	document.write("<PARAM NAME='AutoStart' VALUE='"+m_start+"'>");
	document.write("<PARAM NAME='TransparentAtStart' VALUE='"+m_transparent+"'>");
	document.write("</OBJECT>");
}