<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - ��ǥ����	
+ ���α׷� ID	:  A020001.html
+ �� �� �� ��	:  ��ǥ���縦 �ϴ� ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2007.05.30
-----------------------------------------------------------------------------
+ �� �� �� �� :	   
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>

<jsp:include page="/Account/common/include/head.jsp"/>

<title></title>


<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gs_InsGubun=""; //��ȸ�� ��� ����
var gs_dept2="";    //�渮���úμ�

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
 
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	gcds_dept.Reset();

	ln_Before();
	gclx_fsstat.bindcolval="A";
	gcem_fsdat_fr.text=gs_date.substring(0,6)+"01";
	gcem_fsdat_to.text=gs_date; 
  
	//alert("gs_deptcd::::"+gs_deptcd);
	//�渮���úμ��� �������.
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
     		gclx_fdcode.bindcolval=gs_fdcode;
			gs_dept2="true";
	}else{
	    //alert("gs_fdcode"+gs_fdcode);
		  	gclx_fdcode.bindcolval=gs_fdcode;
			gclx_fdcode.Enable=false;
			gs_dept2="false";
	}

 	gclx_fsstat.Enable = false;
	gclx_fsstat.bindcolval ='Y';
	chkbox_slipcopy.checked==false;
	
}



/******************************************************************************
	Description : ��ȸ
	parameter   : p - 01:��ǥ ��ȸ
	                  02:��ǥ DETAIL ��ȸ - ��ǥ��ȣ��
					  03:��ǥ �Է�ȭ�鿡�� Master�� Dtl ��ȸ

  ����        : ��ǥ DETAIL ��ȸ - ��ǥ��ȣ�� (������ȣ�� 000000 �� ���� ��������+��ǥ��ȣ�θ� ��ȸ��.)
******************************************************************************/
function ln_Query(p){
    var strempno="";
	var strfsknd=""; //���纻

	if (p=='01'){
        var strGubun ="";

		if(gs_dept2=="true"){
			strGubun="A";  //ȸ�� or �繫���� ��츸 
		}else{
      		strGubun="";
		}

		  //�ӽ�
          if(gs_userid=="1990037"||gs_userid=="1990046"||gs_userid=="2020009"||gs_userid=="2020013"||gs_userid=="2040019"
			 ||gs_userid=="2050026"||gs_userid=="2050053"||gs_userid=="2060006"||gs_userid=="3060023"||gs_userid=="6060001"
			 ||gs_userid=="6070001"||gs_userid=="2040080"||gs_userid=="2050028"){
					strGubun="A";  //ȸ�� or �繫���� ��츸 
					strempno="";
			}else{
          		strGubun="";
				strempno=gs_userid;
			}
			
			//alert("strempno::"+strempno);

			if(chkbox_slipcopy.checked==true){
				strfsknd ="C";
			}else{
        		strfsknd="";
			}
			
			gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020013_s1?v_str1="+gs_fdcode
																				 +"&v_str2="+gcem_fsdat_fr.text
																				 +"&v_str3="+gcem_fsdat_to.text
																				 +"&v_str4="+txt_deptcd.value
																				 +"&v_str5="+strGubun
																				 +"&v_str6="+gclx_fsstat.bindcolval
																				 +"&v_str7="+txt_remark.value
																				 +"&v_str8="+gclx_fdcode.bindcolval
																				 +"&v_str9="
																				 +"&v_str10="+strempno
																				 +"&v_str11="+strfsknd;			
			//prompt('',gcds_data01.DataID);																								 																			
			gcds_data01.Reset();
	}
}



/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : �ڵ� �۾�
******************************************************************************/
function ln_Before() {

  	//��������
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();

		//��������2
	gcds_comfield02.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield02.Reset();

	
	//�����ڵ� �����ڵ�
	gcds_code01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?"; 
	//prompt("gcds_code01",gcds_code01.DataID);
	gcds_code01.Reset();

}



/******************************************************************************
	Description : ����� üũ�ڽ��� ��ȯ
	prameter : 
******************************************************************************/
function ln_Chkbox(){

}

/******************************************************************************
	Description : �����ڵ� ã��
	parameter   : p1 - ����,  01-��ǥ�ϰ� ����(���� ==> ��ǥ)
	                          02-����
														03-�����׸�
	              p2 - Data, row - grid�� rowposition
******************************************************************************/
function ln_Popup(p1,p2,row){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="ADD"){
	  arrParam[0]=gcds_data01.namevalue(row,"FDCODE");
		arrParam[1]=gcds_data01.namevalue(row,"FSDAT1");
		arrParam[2]=gcds_data01.namevalue(row,"FSDAT2");
		arrParam[3]=gcds_data01.namevalue(row,"FSNBR");

		if(chkbox_slipcopy.checked==true){
			arrParam[4]="a020013"; //��ǥ����
		}else{
      		arrParam[4]="";
		}
		
		strURL = "./a020009_popup.jsp";   
		strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
	}
}



/******************************************************************************
	Description : ��ǥ����
	prameter    :	    
******************************************************************************/
function ln_SlipCopy(){
  var row ="";
	if (gcds_data01.IsUpdated){

		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				row=i;
			}
		}

		gcds_dtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s7f?v_str1="+gcds_data01.namevalue(row,"FDCODE")
																								 +"&v_str2="+gcds_data01.namevalue(row,"FSDAT")
																								 +"&v_str3="+gcds_data01.namevalue(row,"FSNBR")
																								 +"&v_str4="
																								 +"&v_str5=";																								 
	  gcds_dtl.Reset(); 


		//����üũ && ����üũ 
		for(j=1;j<=gcds_dtl.countrow;j++){
		   //���� �����̸鼭 ������ ��� üũ
			 if(gcds_dtl.namevalue(j,"ATDEBTYN")=="Y"){
					if(gcds_dtl.namevalue(j,"ATDECR")=="1"&&gcds_dtl.namevalue(j,"DAEAMT")!=0){ //���� �϶� �뺯�� �ݾ��� �����ϸ� ����
             alert("�������� ������ �����մϴ�. ������ �� ���� ��ǥ�Դϴ�.");
						 return;
					}else if(gcds_dtl.namevalue(j,"ATDECR")=="2"&&gcds_dtl.namevalue(j,"CHAAMT")!=0){
						 alert("�������� ������ �����մϴ�. ������ �� ���� ��ǥ�Դϴ�.");
						 return;
					}
			 }

			 //����üũ
			 if(gcds_dtl.namevalue(j,"FSWRKDIV")!="01"&&gcds_dtl.namevalue(j,"FSWRKDIV")!=""){
					alert("����ݿ��� ������ �����մϴ�. ������ �� ���� ��ǥ�Դϴ�.");
					return;
			 }
		}

		if(confirm("��ǥ��ȣ�� �����Ͻðڽ��ϱ�?")){	
			gctr_slipcopy.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020013_t1?";
            gctr_slipcopy.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid+",v_str3=" + gs_fdcode;
			gctr_slipcopy.post();
		}
	}
}


/******************************************************************************
	Description : ��ǥ���� ����
	prameter    :	    
******************************************************************************/
function ln_chk_slipcopy_onclick(){
	if(chkbox_slipcopy.checked==true){
		gclx_fsstat.bindcolval ='N';
	}else{
    gclx_fsstat.bindcolval ='Y';
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 


<!-- �������� -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������2 -->
<comment id="__NSID__"><object  id=gcds_comfield02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����ڵ� -->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �α��� �μ� üũ -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥDTL üũ -->
<comment id="__NSID__"><object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ��ǥ��ȣ����-->
<comment id="__NSID__"><object  id=gctr_slipcopy classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020013_t1(I:USER=gcds_data01)">   
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>


<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	if (row>=1){
		txt_deptcd.value=gcds_dept.namevalue(row,"DEPTCD");
		txt_deptnm.value=gcds_dept.namevalue(row,"DEPTNM"); 
		gs_deptcd=gcds_dept.namevalue(row,"DEPTCD");
		gs_deptnm=gcds_dept.namevalue(row,"DEPTNM");
	}
</script>

<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
		gcds_comfield.insertrow(1);
		gcds_comfield.namevalue(1,"FDCODE") = "";
		gcds_comfield.namevalue(1,"FDNAME") = "��ü";
		//gclx_fdcode.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
	if(row!=0&&colid=="CHK") {
		for(i=1;i<=gcds_data01.countrow;i++){
			if(row!=i){
			  if(gcds_data01.namevalue(i,"CHK")=="T"){
					gcds_data01.namevalue(i,"CHK")="F";
					if(gcds_data01.namevalue(i,"CHGDT")!=""){
						gcds_data01.Undo(i);
					}
				}
			}
		}	

		if(gcds_data01.namevalue(row,"CHK")=="T"){
			gcds_data01.namevalue(row,"CHK")="F";
      if(gcds_data01.namevalue(row,"CHGDT")!=""){
				gcds_data01.Undo(row);
			}
		}else{
			gcds_data01.namevalue(row,"CHK")="T";
			if(gcds_data01.namevalue(row,"CHGDT")==""){
				gcds_data01.namevalue(row,"CHGDT")=gs_date;
			}
		}
	}else{
	}

</script>


<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

  if(colid!="CHK"&&colid!="CHGDT"){
		ln_Popup('ADD','',row);
	}
</script>

<script language=JavaScript for=gcem_fsdat02 event=OnKillFocus()>
	//ln_Find_Slipno();
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_slipcopy event=OnSuccess()>
		alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_slipcopy event=OnFail()>
alert("Error Code : " + gctr_slipcopy.ErrorCode + "\n" + "Error Message : " + gctr_slipcopy.ErrorMsg + "\n");

</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a020013_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
					  <img src="../../Common/img/btn/com_btn_slipcopy.gif"   style="cursor:hand" onclick="ln_SlipCopy()">
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('01')">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;ȸ������&nbsp;</nobr></td>
								<td class="tab18" style="width:250px;"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
										~&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
										<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
								</td>
         
                <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ����&nbsp;</nobr></td>
								<td class="tab18" style="width:145px;"><nobr>&nbsp;<comment id="__NSID__">
                  <font style="position:relative;top:-4px;left:0px">������ǥ</font>&nbsp;
                  <input type=checkbox  id=chkbox_slipcopy style="width:15px;position:relative;left:0px;top:-3px;color=#CCFFCC";  onclick="ln_chk_slipcopy_onclick()">&nbsp;&nbsp;&nbsp;
									<object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
											<param name=CBData			   value="A^��ü,Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME">								
											<param name=BindColumn		 value="CODE">

									</object></comment><script>__ws__(__NSID__);</script> 	
								</nobr>
								</td> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;��������</nobr></td>
								<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=ComboDataID    value="gcds_comfield">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value=FDNAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
							</tr>

							 <tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;��    ��&nbsp;</nobr></td>
								<td class="tab19" style="width:547px;" colspan=3><nobr>&nbsp;
									<input id="txt_remark" type="text" class="txtbox"  style= "width:547px;height:20px;position:relative;left:-4px" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query('01')";>
									</nobr>
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;���μ�&nbsp;</nobr></td>
								<td class="tab19" style="width:160px;"><nobr>&nbsp;
									<input id="txt_deptcd" type="text" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px;background-color:#d7d7d7"  readonly="true";>
									<input id="txt_deptnm" type="text" class="txtbox"  style= "width:110px;height:20px;position:relative;left:-4px;background-color:#d7d7d7"  readonly="true";>
									</nobr>
								</td>
							</tr>
					 </table>
					</td>
				</tr>  	
			</table>

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data01">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="true">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='����'		   ID=CHK 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center sort=false SumBgColor=#C3D0DB edit=Numeric EditStyle=CheckBox</C> 
								<C> Name='����'		   ID=FDCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left	 sort=false SumBgColor=#C3D0DB edit=none    EditStyle=Combo Data='01:����,02:����,03:�ݰ���,04:����'</C> 
								<C> Name='��������'	 ID=CHGDT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=68	  align=left	 sort=false SumBgColor=#C3D0DB edit=Numeric MASK='XXXX/XX/XX' BgColor=#ffffcc </C> 
								<C> Name='���' 		 ID=EMPNMK	HeadAlign=Center HeadBgColor=#B9D4DC Width=47	  align=left	 sort=true  SumBgColor=#C3D0DB edit='none'   </C> 								
								<C> Name='��ǥ��ȣ'	 ID=SSDTNB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=107	align=center sort=true  SumBgColor=#C3D0DB edit=none  BgColor=#CCFFCC </C> 
								<C> Name='������ȣ'	 ID=FSDTNB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=107	align=center sort=true  SumBgColor=#C3D0DB edit=none   </C> 
								<C> Name='����'			 ID=REMARK  HeadAlign=Center HeadBgColor=#B9D4DC Width=252	align=left	 sort=true  SumBgColor=#C3D0DB edit=none  SumText='��   ��'</C> 
								<C> Name='�ݾ�'		   ID=FSAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  sort=true  SumBgColor=#C3D0DB edit=none  SumText=@sum</C> 
								<C> Name='����'		   ID=TOGB 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=center sort=true  SumBgColor=#C3D0DB edit=none  EditStyle=Combo Data='01:,02:����,03:ȸ��,05:�Ϸ�,06:�ڱ�' </C> 
								<C> Name='����'		   ID=FSSTAT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center sort=false SumBgColor=#C3D0DB edit=none  EditStyle=Combo Data='Y:����Ϸ�,R:�����û,N:������,C:�������,B:�ݼ�' </C> 
								">
						</object></comment><script>__ws__(__NSID__);</script>   
						<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>		



<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 