<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ��õ�����μ� - ��õ�����׸���	
+ ���α׷� ID	:  A020001.html
+ �� �� �� ��	:  ��õ�����׸��� ��ȸ �ϴ� ȭ���̴�
+ ��   ��  ��      :  �豤ȣ
+ �� �� �� ��     : 
-----------------------------------------------------------------------------
+ �� �� �� ��  :	   
+ ��   ��  ��  :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��õ�����Ը���</title>

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
	
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_dept.Reset();

	//	gclx_fsstat.bindcolval="A";
//	gcem_fsdat_fr.text=gs_date.substring(0,4);

	gcem_staxdatfr.text			= gs_date2 + "01";	//��꼭�Ⱓ from
	gcem_staxdatto.text			= gs_date;					//��꼭�Ⱓ to
	
	//alert("gs_deptcd::::"+gs_deptcd);
	//�渮���úμ��� �������.
	//	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
	//     gclx_fdcode.bindcolval=gs_fdcode;
	//			gs_dept2="true";
	//	}else{
	//alert("gs_fdcode"+gs_fdcode);
	//		  gclx_fdcode.bindcolval=gs_fdcode;
	//		gclx_fdcode.Enable=false;
	//		gs_dept2="false";
	//}
}

/******************************************************************************
	Description : ��ȸ
	parameter   :��õ������ ����
  ����        : 
******************************************************************************/
function ln_Query(){
		var vcode = "";
		var vdatefrom = "";
		var vdateto = "";

		vcode= gclx_fdcode.bindcolval;
	//	vdate = gcem_fsdat_fr.text;

		vdatefrom = gcem_staxdatfr.text		;	//ȸ��Ⱑ from
		vdateto = gcem_staxdatto.text			;			//ȸ��Ⱓ to


		gcds_code03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s2?v_str1="
									+ gclx_fdcode.BindColVal + "&v_str2="; 
		gcds_code03.Reset();

		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160001_s1?v_str1="+vcode
																		+"&v_str2="+vdatefrom+"&v_str3="+vdateto;
		//prompt("",gcds_data01.DataID );																							
		gcds_data01.Reset();
	
}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_PrintHederSet(){

	var THeader1 = "FSDAT:STRING,COSANG:STRING,COID:STRING";
	gcds_temp01.SetDataHeader(THeader1);

}

/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
	//gcgd_disp01.RunExcel("��õ�����׸���");
 gcgd_disp01.GridToExcel("��õ�����׸���","",2);

}

/******************************************************************************
	Description : ���
******************************************************************************/

function ln_Print(){
		//if(gcds_data01.countrow<1) {
		//	alert("����� ������ �����ϴ�.");
		//}else{
			gcds_temp01.clearall();
			ln_PrintHederSet();
			gcds_temp01.addrow();
			gcds_temp01.namevalue(gcds_temp01.countrow,"FSDAT")=gcem_fsdat_fr.text+gcem_fsdat_fr.text;
			gcds_temp01.namevalue(gcds_temp01.countrow,"COSANG")= gcds_code03.namevalue(gcds_code03.rowposition,"COSANG");
			gcds_temp01.namevalue(gcds_temp01.countrow,"COID")="����ڵ�Ϲ�ȣ "+gcds_code03.namevalue(gcds_code03.rowposition,"COID");
			gcrp_print1.preview();
		//}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- Master -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
		<param name=SortExpr   value="+ACTDAT">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
		<param name=SortExpr   value="+ACTDAT">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_code03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"FDCODE")="";
	gcds_dept.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gcds_dept.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
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
					<td><img src="../img/a160001_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
					  <!-- <img src="../../common/img/btn/com_b_trans.gif"   style="cursor:hand" onclick="ln_Popup('00')"> -->
					  <!--   <img src="../../common/img/btn/com_b_trans.gif"   style="cursor:hand" onclick="ln_Popup('01')">
					  <!-- 	<img src="../../common/img/btn/com_b_slipsts.gif"   style="cursor:hand" onclick="ln_Popup('09')">	
					  <!-- 	<img src="../../common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Multi_Confirm()" --> 
					  <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
					  <img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel()" >
						<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;��������&nbsp;</nobr></td>
         
								<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=ComboDataID    value="gcds_dept">
											<param name=CBDataColumns		value="FDCODE, FDNAME">
											<param name=SearchColumn		value=FDNAME>
											<param name=Sort						value=false>
											<param name=ListExprFormat	value="FDNAME^0^140">
											<param name=BindColumn			value=FDCODE>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
						

							<td width="80px" class="tab18" bgcolor="#eeeeee"><nobr>&nbsp;ȸ��⵵&nbsp;</nobr></td>
							<td width="200px"class="tab18"><nobr>&nbsp;
								<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script> 
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
								<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script> 
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
							</td>	
							<!--	<object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> --->
										</nobr>
								</td>
								<td width="600px" class="tab18" align=center>&nbsp;</td>
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
								<param name="Editable"    value="false">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='����'		   ID=REMARK 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=200	  align=LEFT  sort=false SumBgColor=#C3D0DB SumText='��   ��'</C> 
								<C> Name='��Ϲ�ȣ'		   ID=VEND_ID 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=center	 edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='��ȣ�ڵ�'		   ID=VEND_CD	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	 edit=none sort=true SumBgColor=#C3D0DB show=false</C> 
								<C> Name='��ȣ'		   ID=VEND_NM	HeadAlign=Center HeadBgColor=#B9D4DC Width=180	  align=left	 edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='��õ¡����'		   ID=ACTDAT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=CENTER	 edit=none sort=true SumBgColor=#C3D0DB  MASK='XXXX-XX-XX'</C> 
								<C> Name='���ڱݾ�'	 ID=FSREFVAL 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=RIGHT edit=none sort=true SumBgColor=#C3D0DB  SUMTEXT=@sum</C> 
								<C> Name='����'	 ID=TEXRATE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='���μ�'			 ID=DEAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=RIGHT	 edit=none sort=true SumBgColor=#C3D0DB   SUMTEXT=@sum </C> 
								<C> Name='��ǥ����'		 ID=FSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	 edit=none sort=true SumBgColor=#C3D0DB </C> 
								<C> Name='��ǥ��ȣ'		 ID=FSNBR	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	 edit=none sort=true SumBgColor=#C3D0DB </C> 

								
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

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �û�ǥ
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"					VALUE="gcds_temp01">
	<param NAME="DetailDataID"					VALUE="gcds_data01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="false">
	<PARAM NAME="PrintSetupDlgFlag"             VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		        VALUE="true">	
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=793 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=310 ,top=423 ,right=310 ,bottom=503 </L>
	<L> left=66 ,top=609 ,right=1931 ,bottom=609 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='COSANG', left=1619, top=273, right=1926, bottom=328, face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���θ�' ,left=1487 ,top=273 ,right=1609 ,bottom=328 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��õ���μ��� ������(��)' ,left=476 ,top=265 ,right=1378 ,bottom=331 ,face='����ü' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=66 ,top=384 ,right=1931 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='FSDAT', left=167, top=225, right=362, bottom=280 ,mask='XXXX-01-01', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=370 ,top=212 ,right=370 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=415 ,top=423 ,right=415 ,bottom=503 </L>
	<C>id='FSDAT', left=167, top=318, right=362, bottom=373 ,mask='XXXX-12-31', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=362 ,top=423 ,right=362 ,bottom=503 </L>
	<L> left=476 ,top=611 ,right=476 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=212 ,right=1931 ,bottom=212 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=212 ,right=1931 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='[���� ��10ȣ ����(��)] 2005.02 ����' ,left=66 ,top=146 ,right=717 ,bottom=201 ,align='left' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=238 ,top=280 ,right=294 ,bottom=318 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=524 ,top=423 ,right=524 ,bottom=505 </L>
	<T>id='����μ�' ,left=1720 ,top=675 ,right=1908 ,bottom=730 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�뼼��' ,left=1566 ,top=675 ,right=1688 ,bottom=730 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڱݾ�' ,left=1349 ,top=675 ,right=1537 ,bottom=730 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���õ¡����' ,left=1095 ,top=675 ,right=1318 ,bottom=730 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����  ��' ,left=183 ,top=675 ,right=384 ,bottom=730 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1693 ,top=609 ,right=1693 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1561 ,top=609 ,right=1561 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1323 ,top=609 ,right=1323 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1085 ,top=609 ,right=1085 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=741 ,top=688 ,right=741 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=212 ,right=66 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=794 ,right=1931 ,bottom=794 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(����)' ,left=855 ,top=741 ,right=971 ,bottom=791 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=855 ,top=693 ,right=971 ,bottom=743 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ϲ�ȣ' ,left=489 ,top=741 ,right=730 ,bottom=791 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����(�ֹ�)' ,left=489 ,top=693 ,right=730 ,bottom=743 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���õ¡���ǹ���' ,left=635 ,top=622 ,right=955 ,bottom=677 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COID', left=1244, top=463, right=1828, bottom=519, face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=376 ,top=463 ,right=402 ,bottom=463 </L>
	<L> left=468 ,top=423 ,right=468 ,bottom=503 </L>
	<L> left=415 ,top=503 ,right=524 ,bottom=503 </L>
	<L> left=415 ,top=423 ,right=524 ,bottom=423 </L>
	<L> left=138 ,top=423 ,right=362 ,bottom=423 </L>
	<L> left=138 ,top=503 ,right=362 ,bottom=503 </L>
	<L> left=138 ,top=423 ,right=138 ,bottom=503 </L>
	<L> left=257 ,top=423 ,right=257 ,bottom=503 </L>
	<T>id='�� ȣ' ,left=153 ,top=463 ,right=243 ,bottom=500 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=153 ,top=429 ,right=243 ,bottom=466 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=93 ,top=437 ,right=135 ,bottom=492 ,align='left' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�ö��� �������� ���ʽÿ�.' ,left=93 ,top=529 ,right=624 ,bottom=585 ,align='left' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=71 ,top=304 ,right=156 ,bottom=360 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=71 ,top=238 ,right=156 ,bottom=294 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1482 ,top=212 ,right=1482 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=476 ,top=688 ,right=1085 ,bottom=688 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1614 ,top=212 ,right=1614 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=159 ,top=212 ,right=159 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='REMARK', left=71, top=11, right=468, bottom=69, align='left', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=66 ,top=0 ,right=66 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=476 ,top=0 ,right=476 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=741 ,top=0 ,right=741 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1085 ,top=0 ,right=1085 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VEND_NM', left=749, top=11, right=1077, bottom=69, align='left', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1323 ,top=0 ,right=1323 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ACTDAT', left=1093, top=11, right=1315, bottom=69 ,mask='XXXX/XX/XX', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1561 ,top=0 ,right=1561 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='FSREFVAL', left=1331, top=11, right=1556, bottom=69, align='right', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1693 ,top=0 ,right=1693 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TEXRATE', left=1566, top=11, right=1688, bottom=69, align='right' ,mask='XX%', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEAMT', left=1699, top=11, right=1926, bottom=69, align='right', face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=66 ,top=79 ,right=1931 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VEND_ID', left=489, top=11, right=733, bottom=69, face='����ü', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2000 ,bottom=212 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=66 ,top=79 ,right=1931 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1693 ,top=0 ,right=1693 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1561 ,top=0 ,right=1561 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1323 ,top=0 ,right=1323 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1085 ,top=0 ,right=1085 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=741 ,top=0 ,right=741 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=476 ,top=0 ,right=476 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=66 ,top=0 ,right=66 ,bottom=79 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<S>id='{Sum(FSREFVAL)}' ,left=1331 ,top=11 ,right=1556 ,bottom=66 ,align='right' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(DEAMT)}' ,left=1701 ,top=11 ,right=1926 ,bottom=66 ,align='right' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<T>id='22226-01821��' ,left=64 ,top=87 ,right=373 ,bottom=130 ,align='left' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1999.4.1 ��������' ,left=64 ,top=127 ,right=373 ,bottom=169 ,align='left' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�Ź����� 54g/��)' ,left=1622 ,top=127 ,right=1931 ,bottom=169 ,align='right' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='210mm��297mm' ,left=1622 ,top=87 ,right=1931 ,bottom=130 ,align='right' ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=74 ,top=11 ,right=468 ,bottom=66 ,face='����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
--------------------------------------------------------------------------------->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 