<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	ȸ�����/���������
+ ���α׷� ID	: A010045.html
+ �� �� �� ��	: ������ ���
+ �� �� �� ��	: ������
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010045_s1 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>����������</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	gclx_cocode.index=2;
	ln_Find_Regno();
	ln_Query(gcem_regno.text);
}
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(strRegno){
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010045_s1?v_str1=" + strRegno //����� ��Ϲ�ȣ 
	//prompt("",gcds_data.DataID);
  gcds_data.Reset();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Cert_Reg(){

  alert('������ ���');		
		
  var intS=0;
  var intG=0;
	//var url="";

	//alert("000intS::"+intS +":CHK:"+gcds_data.namevalue(intS,"CHK"));
	//alert("000intG::"+intG +":CHK:"+gcds_data.namevalue(intG,"CHK"));

  if(!ln_Chk()) return;	
  
  var v_left = (screen.width-300)/2;
  var v_top  = (screen.height-300)/2;
  //var v_left = screen.availWidth/2 - 300/2; 
  //var v_top  = screen.availHeight/2 - 300/2;   
	
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"CERT_REGNO")=="1018510695"){
			intS=i;
		}

		if(gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"CERT_REGNO")=="2218113834"){
			intG=i;
		}
	}
	
	//alert("intS::"+intS +":CHK:"+gcds_data.namevalue(intS,"CHK"));
	//alert("intG::"+intG +":CHK:"+gcds_data.namevalue(intG,"CHK"));
	
	if(gcds_data.namevalue(intS,"CHK")=="T"&& intS>0 ){        //������ ���
		url=gs_url+"/callSB_V3/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_s+"&CERT_COMNAME="+gs_comname_s;		
	}else if(gcds_data.namevalue(intG,"CHK")=="T" && intG>0){  //���� ���
		url=gs_url+"/callSB_V3/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_g+"&CERT_COMNAME="+gs_comname_g;	
	}

	alert("url:::"+url);
	//return;

  	window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}

/******************************************************************************
	Description : ����� �ڵ�� ����ڵ�Ϲ�ȣ ã�� 
******************************************************************************/
function ln_Find_Regno(){
	if(gclx_cocode.bindcolval=="01"){
		gcem_regno.text =gs_regno_g;
	}else if(gclx_cocode.bindcolval=="02"){
    	gcem_regno.text =gs_regno_s;
	}else{
      	gcem_regno.text ="";
	}
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Chk(){
	var intcnt = 0; 

  //������ ������ �� �͵� �� �Ȱ��
  for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	
  if (intcnt==0){
		alert("�ش� ����� ��ȣ�� �����Ͻʽÿ�.");
		return false;
	}else if(intcnt==1){
    	return true;
	}else if(intcnt==2){
		alert("����� ��ȣ�� 1�Ǹ� �����Ͻʽÿ�.");
		return false;
	}else{
    	alert("��Ÿ");
    	return false;
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

	//alert("row:"+rowcount);

	for(i=1;i<=rowcount;i++){
		//alert("999iiii::"+i +":CHK:"+gcds_data.namevalue(i,"CHK"));
	}


</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
	ln_Find_Regno();
  ln_Query(gcem_regno.text);
</script>

<script language="javascript"  for=gcgd_data event="OnClick(Row,Colid)">

  if (Colid =="CHK") {
		for (var i=1;i<=gcds_data.countrow;i++) {
		 // alert("i::"+i+":row:"+Row);
			if(i== Row) {
			  if(gcds_data.namevalue(i,"CHK")== "T") gcds_data.namevalue(i,"CHK") = "F";
				if(gcds_data.namevalue(i,"CHK")== "F") gcds_data.namevalue(i,"CHK") = "T";
			}else{
        gcds_data.namevalue(i,"CHK") = "F";
			}
		}
	}
	
</script>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010045_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
      <img src=" <%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_banyoung1.gif" style="cursor:hand" onclick="ln_Cert_Reg()">&nbsp;&nbsp;
		</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>�����</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gclx_cocode      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120>
					<param name=CBData			  value="00^��ü,01^��,02^����">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			      value=false>
					<param name=ListExprFormat	Value="CODE^1^30,NAME^1^90">								
					<param name=BindColumn		  value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script>
			</td>
			<td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>����ڵ�Ϲ�ȣ</nobr></td>
			<td width="400px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
			<object id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:80px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="000-00-00000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=true>
				</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
			</tr>
		</table>
   </td>
	</tr>
	<tr>
	<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_data">
						<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="IndWidth"      value="0">
						<param name="Fillarea"		  VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<PARAM NAME="Format"			  VALUE="  
						<C> Name='����'	           ID=CHK         	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40	align=center	EditStyle=CheckBox </C> 
						<C> Name='����ڵ�Ϲ�ȣ'	 ID=CERT_REGNO	     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center  edit=none  Mask='XXX-XX-XXXXX'</C>
						<C> Name='ȸ���'			     ID=CERT_COMNAME  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		edit=none</C>
						<C> Name='������DN'		     ID=USERDN 		       HeadAlign=Center HeadBgColor=#B9D4DC Width=300 align=left		edit=none</C>
						<C> Name='����������'      ID=USERINFO			   HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left  	edit=none</C>
						<C> Name='������������'    ID=EXPIRATION_DATE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	edit=none</C>
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		</table> 
  </td>
	</tr>
	<tr><td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td> </tr>	 
</table>

<!-- <iframe id="eTax_ifrm"  name="eTax_ifrm" style="width:870;height:100px;border:0 solid #708090;" src="../../Account/html/eTax_ifrm.html" frameborder=0 ></iframe>
 --></body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



