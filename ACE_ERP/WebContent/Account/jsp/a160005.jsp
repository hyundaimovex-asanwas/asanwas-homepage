<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - ����ҵ��õ¡��
+ ���α׷� ID	:  a160005.jsp
+ �� �� �� ��	:  ����ҵ��õ¡�� 
+ ��   ��  ��      :  �� �� ��
+ �� �� �� ��	:  a160005_s1, a160005_t1, excel_upload_a160005_t1
-----------------------------------------------------------------------------
+ �� �� �� ��     :	         
+ ��   ��  ��      : 
+ �� �� �� ��     :  2014.10.8
+ �� �� �� ��	:
------------------------------------------------------------------------------*/
%>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>����ҵ��õ¡��</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�

var gs_frdt="";
var gs_todt="";

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
}
<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){
	gcem_yyyy.text       = gs_date2;	//�⵵
	gclx_mm.bindcolval   = gcurdate.substring(5,7);	//��
	gcrdo_prt_option.CodeValue="1";
}

<%
/******************************************************************************
	Description : ���� ���� ��ư �۾��� ����Data ==> Grid�� ���ε� ��               
******************************************************************************/
%>
function ln_Excel_Apply(){
    var s_temp = "";
	
	//������ �ʱ�ȭ ( ȭ�� Clear ) 
	gcds_excel_grid.clearAll();
    //excel_upload ( grid�� ���� )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head �����
    //���ϰ��
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL") = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_a160005_t1(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_a160005_t1";

	gctr_data_excel.post();
		
}

<%
/******************************************************************************************
	Description : ����ҵ��õ¡�� DB INSERT
*****************************************************************************************/
%>
function ln_Create(){
		
	gcds_excel_grid.UseChangeInfo = "false";	

	if (confirm("����ҵ� ��õ¡�� �����͸� ���ε� �Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue = "Account.a160005_t1(I:USER=gcds_excel_grid)";
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160005_t1?";
			gctr_data.post();
	}

}

<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(){

	if(gcem_yyyy.text==""){
		alert("�⵵�� �Է��Ͻʽÿ�.");
		return;
	} 
    
	gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a160005_s1?v_str1="+gcem_yyyy.text
	       															          +"&v_str2="+gclx_mm.bindcolval
	  																		  +"&v_str3="+gcem_ea_nm.text;
    //prompt('',gcds_excel_grid.DataID);
	gcds_excel_grid.Reset();
}

<%
/******************************************************************************
	Description : ���
******************************************************************************/
%>
function ln_Print(){
		
	gcds_prt.clearAll();	
		
	ln_SetDataHeader();
	
	for( var i=1;i<=gcds_excel_grid.countrow;i++){
		
		gcds_prt.Addrow();
		
		gcds_prt.namevalue(i,"CCHK1")= "V";
		gcds_prt.namevalue(i,"CCHK2")= "";
		
		if(gcrdo_prt_option.CodeValue=="1"){
			gcds_prt.namevalue(i,"CCHK3")= "V";  //�ҵ��� ������
			gcds_prt.namevalue(i,"CCHK4")= "";   //������ ������
			gcds_prt.namevalue(i,"CCHK6")= gcds_excel_grid.namevalue(i,"EA_NM");
			
		}else if (gcrdo_prt_option.CodeValue=="2"){
			gcds_prt.namevalue(i,"CCHK3")= "";  //�ҵ��� ������
			gcds_prt.namevalue(i,"CCHK4")= "V"; //������ ������
			gcds_prt.namevalue(i,"CCHK6")= "�� �� �� ��";
		}
				
		if(gcds_excel_grid.namevalue(i,"INOUT_GB")=="1"){
			gcds_prt.namevalue(i,"CCHK5")= "������1"	
		}else if (gcds_excel_grid.namevalue(i,"INOUT_GB")=="9"){
			gcds_prt.namevalue(i,"CCHK5")= "�ܱ���9"
		}
			
		gcds_prt.namevalue(i,"CYMD")= gcurdate.substring(0,4) +"��"+ gcurdate.substring(5,7)+"��"+ gcurdate.substring(8,10)+"��";
		
		gcds_prt.namevalue(i,"PAY_Y")=gcds_excel_grid.namevalue(i,"PAY_DT").substring(0,4);	
		gcds_prt.namevalue(i,"PAY_M")=gcds_excel_grid.namevalue(i,"PAY_DT").substring(4,6);	
		gcds_prt.namevalue(i,"PAY_D")=gcds_excel_grid.namevalue(i,"PAY_DT").substring(6,8);	
		
		
		gcds_prt.namevalue(i,"YYYY")=gcds_excel_grid.namevalue(i,"YYYY");
		gcds_prt.namevalue(i,"INC_MM")=gcds_excel_grid.namevalue(i,"INC_MM");
		gcds_prt.namevalue(i,"INC_SEQ")=Number(gcds_excel_grid.namevalue(i,"INC_SEQ"));
		gcds_prt.namevalue(i,"PAY_DT")=gcds_excel_grid.namevalue(i,"PAY_DT");
		gcds_prt.namevalue(i,"CO_CRNO")=gcds_excel_grid.namevalue(i,"CO_CRNO");
		gcds_prt.namevalue(i,"CO_NO")=gcds_excel_grid.namevalue(i,"CO_NO");
		gcds_prt.namevalue(i,"CO_NM")=gcds_excel_grid.namevalue(i,"CO_NM");
		gcds_prt.namevalue(i,"CO_RENM")=gcds_excel_grid.namevalue(i,"CO_RENM");
		gcds_prt.namevalue(i,"CO_AD")=gcds_excel_grid.namevalue(i,"CO_AD");
		gcds_prt.namevalue(i,"EA_NM")=gcds_excel_grid.namevalue(i,"EA_NM");
		gcds_prt.namevalue(i,"EA_NO")=gcds_excel_grid.namevalue(i,"EA_NO");
		gcds_prt.namevalue(i,"EA_AD")=gcds_excel_grid.namevalue(i,"EA_AD");
		gcds_prt.namevalue(i,"EA_CRNO")=gcds_excel_grid.namevalue(i,"EA_CRNO");
		gcds_prt.namevalue(i,"EA_FMARK")=gcds_excel_grid.namevalue(i,"EA_FMARK");
		gcds_prt.namevalue(i,"EA_FAD")=gcds_excel_grid.namevalue(i,"EA_FAD");
		gcds_prt.namevalue(i,"EA_BSGB")=gcds_excel_grid.namevalue(i,"EA_BSGB");
		gcds_prt.namevalue(i,"TOT_AMT")=Number(gcds_excel_grid.namevalue(i,"TOT_AMT"));
		gcds_prt.namevalue(i,"TAX_RATE")=Number(gcds_excel_grid.namevalue(i,"TAX_RATE"));
		gcds_prt.namevalue(i,"INC_TAX")=Number(gcds_excel_grid.namevalue(i,"INC_TAX"));
		gcds_prt.namevalue(i,"LINC_TAX")=Number(gcds_excel_grid.namevalue(i,"LINC_TAX"));
		gcds_prt.namevalue(i,"SUM_AMT")=Number(gcds_excel_grid.namevalue(i,"SUM_AMT"));
		gcds_prt.namevalue(i,"INOUT_GB")=gcds_excel_grid.namevalue(i,"INOUT_GB");
		gcds_prt.namevalue(i,"RESID_NM")=gcds_excel_grid.namevalue(i,"RESID_NM");
		gcds_prt.namevalue(i,"RESID_GB")=gcds_excel_grid.namevalue(i,"RESID_GB");	
	}
	gcrp_print.Preview();
}

<%
/******************************************************************************
Description : ���
******************************************************************************/
%>
function ln_SetDataHeader(){
	
	var s_tmp1="";
		
	s_tmp1 ="CCHK1:STRING,CCHK2:STRING,CCHK3:STRING,CCHK4:STRING,CCHK5:STRING,"
		   +"CCHK6:STRING,CYMD:STRING,PAY_Y:STRING,PAY_M:STRING,PAY_D:STRING," 
		   +"YYYY:STRING,INC_MM:STRING,INC_SEQ:DECIMAL,PAY_DT:STRING,CO_CRNO:STRING,"	
		   +"CO_NO:STRING,CO_NM:STRING,CO_RENM:STRING,CO_AD:STRING,EA_NM:STRING,"	
		   +"EA_NO:STRING,EA_AD:STRING,EA_CRNO:STRING,EA_FMARK:STRING,EA_FAD:STRING,"		
		   +"EA_BSGB:STRING,TOT_AMT:DECIMAL,TAX_RATE:DECIMAL,INC_TAX:DECIMAL,LINC_TAX:DECIMAL,"		
		   +"SUM_AMT:DECIMAL,INOUT_GB:STRING,RESID_NM:STRING,RESID_GB:STRING,"		
		   +"CREATE_ID:STRING,CREATE_DATE:STRING,UPDATE_ID:STRING,UPDATE_DATE";		
	gcds_prt.SetDataHeader(s_tmp1);
	
}

<%
/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
%>
function ln_Excel(){
	gcgd_disp01.GridToExcel("����ҵ� ��õ¡��","",2);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_excel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_excel_grid classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_prt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_excel_grid" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {	
		file_path.value = gcip_file.value;
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td colspan=2  height="20px"><strong><font size="2" color="blue">&nbsp;[���Ͼ��ε�]</font></strong></td></tr>
	<tr>
		<td colspan=2 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:1000;height:30px;font-size:9pt;background-color:#ffffff;">
			<tr> 
				<td width="102px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>��������</nobr></td>
				<td class="tab18" ><nobr>&nbsp;
					<input type="text" name="file_path" value="" style="width:600px;position:relative;top:-2px" >&nbsp;
					<comment id="__NSID__">
					<object id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03	style="width:70;height:20;position:relative;top:4px;fontSize=8"  >
						<param name = "Text"		value="ã�ƺ���">
					</object>&nbsp;
					</comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</nobr>	
					<img src="../../Common/img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:3px"  onClick="ln_Excel_Apply()">
					<img src="../../Common/img/btn/com_b_save.gif"    style="cursor:hand;position:relative;top:3px"  onClick="ln_Create()">
				</td> 
			</tr>
			</table>
		</td>
	</tr>
    <tr><td height="35px"><strong><font size="2" color="blue">&nbsp;[��ȸ����]</font></strong></td>
        <td align="right">&nbsp;<nobr>      
			<img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;top:2px;right:2px"	onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"	  style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
			</nobr>
		</td>          
    </tr>
	<tr>
		<td colspan=2 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ͼӳ⵵</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ҵ���</nobr></td>
					<td class="tab23" ><nobr><comment id="__NSID__">
						<object  id=gclx_mm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:60px;height:20px;">
							<param name=CBData				value="01^1��,02^2��,03^3��,04^4��,05^5��,06^6��,07^7��,08^8��,09^9��,10^10��,11^11��,12^12��,">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^60">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>����</nobr></td>
					<td class="tab23" style="width:120px" ><nobr><comment id="__NSID__">
						<object id=gcem_ea_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:100px;height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=GeneralEdit   value="true">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��¿ɼ�</nobr></td>
					<td><nobr><comment id="__NSID__">
						<object id=gcrdo_prt_option classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:20; width:200">
							<param name=Cols	value="2">
							<param name=Format	value="1^�ҵ��� ������,2^������ ������">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td colspan=2  ALIGN=CENTER>
		<table width="1000" cellpadding="1" cellspacing="0" border="0">
			<tr><td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
				<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:1000px;HEIGHT:420px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
					<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
					<PARAM NAME="Editable"		VALUE="false">
					<PARAM NAME="BorderStyle"	VALUE="0">
					<PARAM NAME="IndWidth"		VALUE="0">
					<PARAM NAME="ColSizing"		VALUE="true">
					<param NAME="Fillarea"      VALUE="true">
					<param name=SortView        value="Left">
					<PARAM NAME="viewSummary"	VALUE="1">
					<PARAM NAME="Format"        VALUE="  
					<C> Name='�ͼӳ⵵'	   	    ID=YYYY      	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB'  </C>
					<C> Name='�ҵ��'		        ID=INC_MM   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB'  </C>
					<C> Name='����'			    ID=INC_SEQ  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='���޳����'		    ID=PAY_DT   	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center	SumBgColor='#C3D0DB' sort=true MASK='XXXX-XX-XX'</C>
					<C> Name='����'		        ID=EA_NM    	HeadAlign=Center HeadBgColor=#B9D4DC Width=60   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='�ֹι�ȣ'	        ID=EA_NO    	HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=center	SumBgColor='#C3D0DB' sort=true MASK='XXXXXX-X******'</C>
					<C> Name='�ּ�'		        ID=EA_AD    	HeadAlign=Center HeadBgColor=#B9D4DC Width=150  align=left  	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='����ڹ�ȣ'	        ID=EA_CRNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=center	SumBgColor='#C3D0DB' sort=true MASK='XXX-XX-XXXXX'</C>
					<C> Name='��ȣ'		        ID=EA_FMARK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='����������'	    ID=EA_FAD   	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left  	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='��������'		    ID=EA_BSGB  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='�����Ѿ�'		    ID=TOT_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='����'			    ID=TAX_RATE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center  	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='�ҵ漼'		        ID=INC_TAX  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='����ҵ漼'		    ID=LINC_TAX 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='��'			    ID=SUM_AMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right 	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='���ܱ���'		    ID=INOUT_GB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='��������'		    ID=RESID_NM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center	SumBgColor='#C3D0DB' sort=true </C>
					<C> Name='���������ڵ�'		ID=RESID_GB 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center	SumBgColor='#C3D0DB' sort=true </C>
					">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<fieldset style="position:relative;left:5px;width:1002px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		<tr>
	</table>			
	</td> 
	</tr> 
</table> 
			 
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_mst">
	<param name="DetailDataID"			    value="gcds_prt">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"				VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="TRUE">
	<param name="SuppressColumns"	        value="1:pageskip,EA_NO; ">
	<PARAM NAME="Format"                    VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=1002 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1490 ,top=74 ,right=1918 ,bottom=262 ,border=true</X>
	<X>left=1490 ,top=74 ,right=1918 ,bottom=169 ,border=true</X>
	<X>left=153 ,top=79 ,right=273 ,bottom=198 ,border=true</X>
	<X>left=37 ,top=79 ,right=156 ,bottom=198 ,border=true</X>
	<L> left=40 ,top=452 ,right=1918 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1643 ,top=606 ,right=1643 ,bottom=683 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1164 ,top=288 ,right=1164 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=482 ,top=291 ,right=482 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=167 ,top=291 ,right=167 ,bottom=762 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=209 ,top=921 ,right=209 ,bottom=1003 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=275 ,top=759 ,right=275 ,bottom=997 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EA_BSGB', left=278, top=767, right=492, bottom=833, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EA_AD', left=484, top=688, right=1905, bottom=754, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EA_NM', left=484, top=611, right=807, bottom=677, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EA_FAD', left=484, top=537, right=1908, bottom=603, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EA_CRNO', left=1646, top=460, right=1908, bottom=527, align='left' ,mask='XXX-XX-XXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EA_FMARK', left=484, top=460, right=804, bottom=527, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_AD', left=1167, top=381, right=1908, bottom=447, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_NO', left=484, top=381, right=804, bottom=447, align='left' ,mask='XXXXXX-XXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_RENM', left=1662, top=302, right=1908, bottom=368, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_NM', left=1167, top=302, right=1487, bottom=368, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_CRNO', left=484, top=299, right=804, bottom=365, align='left' ,mask='XXX-XX-XXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1328 ,top=606 ,right=1328 ,bottom=683 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1328 ,top=452 ,right=1328 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(3)����' ,left=1527 ,top=299 ,right=1656 ,bottom=373 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� �ۼ���� ����' ,left=500 ,top=762 ,right=847 ,bottom=836 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=958 ,top=839 ,right=958 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=148 ,top=918 ,right=148 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=386 ,top=918 ,right=386 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=209 ,top=921 ,right=267 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��' ,left=151 ,top=921 ,right=209 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1582 ,top=918 ,right=1582 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1283 ,top=918 ,right=1283 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=958 ,top=918 ,right=1921 ,bottom=918 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=788 ,top=839 ,right=788 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=918 ,right=495 ,bottom=918 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(16)����' ,left=796 ,top=847 ,right=955 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(16)�����Ѿ�' ,left=503 ,top=847 ,right=786 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=42 ,top=1000 ,right=1921 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(19)��' ,left=1588 ,top=921 ,right=1916 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� õ ¡ �� �� �� ' ,left=963 ,top=841 ,right=1916 ,bottom=915 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��' ,left=53 ,top=921 ,right=148 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��' ,left=389 ,top=921 ,right=495 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��' ,left=278 ,top=921 ,right=384 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=497 ,top=757 ,right=497 ,bottom=1000 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(17)�ҵ漼' ,left=963 ,top=921 ,right=1278 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(18)����ҵ漼' ,left=1291 ,top=921 ,right=1577 ,bottom=995 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(14)�ҵ�ͼ�' ,left=275 ,top=841 ,right=495 ,bottom=915 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(13)��      ��' ,left=53 ,top=841 ,right=273 ,bottom=915 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(12)��������' ,left=53 ,top=762 ,right=273 ,bottom=836 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=42 ,top=839 ,right=1921 ,bottom=839 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(11)��         ��' ,left=172 ,top=685 ,right=479 ,bottom=759 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(10)�ֹε�Ϲ�ȣ' ,left=1334 ,top=609 ,right=1640 ,bottom=683 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(7)����ڵ�Ϲ�ȣ' ,left=1334 ,top=455 ,right=1640 ,bottom=529 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ҵ���' ,left=53 ,top=561 ,right=161 ,bottom=635 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ǹ���' ,left=53 ,top=373 ,right=161 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='¡ ��' ,left=53 ,top=299 ,right=161 ,bottom=373 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=815 ,top=288 ,right=815 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1521 ,top=291 ,right=1521 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=167 ,top=683 ,right=1916 ,bottom=683 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=167 ,top=606 ,right=1916 ,bottom=606 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=167 ,top=529 ,right=1916 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(9)��           ��' ,left=172 ,top=609 ,right=479 ,bottom=683 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(8)����������' ,left=172 ,top=532 ,right=479 ,bottom=606 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(6)��           ȣ' ,left=172 ,top=455 ,right=479 ,bottom=529 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=42 ,top=759 ,right=1921 ,bottom=759 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(5)������ �Ǵ� �ּ�' ,left=820 ,top=376 ,right=1162 ,bottom=450 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(4)���ε�Ϲ�ȣ' ,left=172 ,top=376 ,right=479 ,bottom=450 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=167 ,top=373 ,right=1916 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='(2)���θ� �Ǵ� ��ȣ' ,left=820 ,top=296 ,right=1162 ,bottom=370 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='(1)����ڵ�Ϲ�ȣ' ,left=172 ,top=296 ,right=479 ,bottom=370 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=40 ,top=291 ,right=1918 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='RESID_GB', left=1857, top=177, right=1908, bottom=243, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK5', left=1715, top=90, right=1905, bottom=156, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1844 ,top=167 ,right=1844 ,bottom=259 </L>
	<C>id='RESID_NM', left=1577, top=183, right=1701, bottom=249, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��.�ܱ���' ,left=1521 ,top=90 ,right=1675 ,bottom=156 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��      ��' ,left=1707 ,top=214 ,right=1844 ,bottom=259 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1707 ,top=169 ,right=1844 ,bottom=214 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1492 ,top=169 ,right=1574 ,bottom=214 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1490 ,top=214 ,right=1572 ,bottom=259 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1574 ,top=167 ,right=1574 ,bottom=262 </L>
	<L> left=1701 ,top=74 ,right=1701 ,bottom=265 </L>
	<C>id='CCHK4', left=926, top=209, right=976, bottom=267, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK3', left=479, top=209, right=529, bottom=267, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=']�ҵ��� ������     [' ,left=529 ,top=209 ,right=926 ,bottom=267 ,align='left' ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( [' ,left=413 ,top=209 ,right=479 ,bottom=267 ,align='left' ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=']  ������ ������  )' ,left=976 ,top=209 ,right=1392 ,bottom=267 ,align='left' ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CCHK1', left=389, top=74, right=439, bottom=132, align='left', face='����', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK2', left=389, top=135, right=439, bottom=193, align='left', face='����', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=']' ,left=434 ,top=74 ,right=474 ,bottom=132 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=']' ,left=434 ,top=135 ,right=474 ,bottom=193 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[' ,left=349 ,top=135 ,right=389 ,bottom=193 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[' ,left=349 ,top=74 ,right=389 ,bottom=132 ,face='Arial' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='YYYY', left=156, top=108, right=270, bottom=175, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ͼ�' ,left=61 ,top=93 ,right=135 ,bottom=140 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⵵' ,left=61 ,top=140 ,right=135 ,bottom=188 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� ����ҵ� ���޸���' ,left=482 ,top=135 ,right=1437 ,bottom=193 ,align='left' ,face='����' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� ����ҵ� ��õ¡�������� ' ,left=479 ,top=74 ,right=1434 ,bottom=132 ,align='left' ,face='����' ,size=16 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1643 ,top=452 ,right=1643 ,bottom=529 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1659 ,top=294 ,right=1659 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EA_NO', left=1646, top=611, right=1918, bottom=677, align='left' ,mask='XXXXXX-X******', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='SUM_AMT', left=1588, top=0, right=1916, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LINC_TAX', left=1291, top=0, right=1577, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='LINC_TAX', left=963, top=0, right=1278, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAX_RATE', left=796, top=0, right=955, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TOT_AMT', left=503, top=0, right=786, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INC_MM', left=389, top=0, right=495, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='YYYY', left=278, top=0, right=384, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_D', left=209, top=0, right=267, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_M', left=151, top=0, right=209, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_Y', left=53, top=0, right=148, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=148 ,top=0 ,right=148 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=42 ,top=50 ,right=1921 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=209 ,top=0 ,right=209 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=386 ,top=0 ,right=386 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=497 ,top=0 ,right=497 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=958 ,top=0 ,right=958 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=788 ,top=0 ,right=788 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1283 ,top=0 ,right=1283 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1582 ,top=0 ,right=1582 ,bottom=48 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=275 ,top=0 ,right=275 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=730 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='���� ��õ¡������(���Աݾ�)�� ���� ����(����)�մϴ�.' ,left=140 ,top=13 ,right=1050 ,bottom=61 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. �� ������ �����ڰ� ����ҵ��� �߻��� ��쿡�� �ۼ��ϸ�, ������ڴ� ���� �� 23ȣ����(5)�� ����Ͽ��� �մϴ�.' ,left=58 ,top=352 ,right=1897 ,bottom=394 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='2.¡���ǹ��ڶ��� (4)�ֹ�(����)��Ϲ�ȣ�� �ҵ��� �����뿡�� ���� �ʽ��ϴ�.' ,left=58 ,top=394 ,right=1897 ,bottom=437 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='3.������ �Ҿ׺�¡���� �ش��ϴ� ��쿡�� (17),(18)(19)���� ������ 0���� �����ϴ�.' ,left=58 ,top=437 ,right=1897 ,bottom=479 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='4. (12)�������ж����� �ҵ����� ������ �ش��ϴ� �Ʒ��� ���������ڵ带 ����� �մϴ�.' ,left=58 ,top=479 ,right=1897 ,bottom=521 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<T>id='�� �� �� ��' ,left=58 ,top=304 ,right=1897 ,bottom=347 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A0A0A4</T>
	<T>id='�����ڵ�' ,left=58 ,top=527 ,right=243 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=243 ,top=527 ,right=429 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=614 ,top=527 ,right=799 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�����ڵ�' ,left=429 ,top=527 ,right=614 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=984 ,top=527 ,right=1169 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�����ڵ�' ,left=799 ,top=527 ,right=984 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=1355 ,top=527 ,right=1540 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�����ڵ�' ,left=1169 ,top=527 ,right=1355 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�����ڵ�' ,left=1540 ,top=527 ,right=1725 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=1725 ,top=527 ,right=1910 ,bottom=556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940100' ,left=58 ,top=556 ,right=243 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='������' ,left=243 ,top=556 ,right=429 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���ǰ�' ,left=614 ,top=556 ,right=799 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940305' ,left=429 ,top=556 ,right=614 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�������' ,left=984 ,top=556 ,right=1169 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940904' ,left=799 ,top=556 ,right=984 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ٴܰ��Ǹ�' ,left=1355 ,top=556 ,right=1540 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940910' ,left=1169 ,top=556 ,right=1355 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940916' ,left=1540 ,top=556 ,right=1725 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��絵���' ,left=1725 ,top=556 ,right=1910 ,bottom=585 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ɺθ��뿪' ,left=1725 ,top=585 ,right=1910 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940917' ,left=1540 ,top=585 ,right=1725 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940911' ,left=1169 ,top=585 ,right=1355 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��Ÿ��������' ,left=1355 ,top=585 ,right=1540 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940905' ,left=799 ,top=585 ,right=984 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����������' ,left=984 ,top=585 ,right=1169 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940500' ,left=429 ,top=585 ,right=614 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��������' ,left=614 ,top=585 ,right=799 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ȭ������' ,left=243 ,top=585 ,right=429 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940200' ,left=58 ,top=585 ,right=243 ,bottom=614 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940301' ,left=58 ,top=614 ,right=243 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�۰' ,left=243 ,top=614 ,right=429 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ڹ�.��' ,left=614 ,top=614 ,right=799 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940600' ,left=429 ,top=614 ,right=614 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���輳��' ,left=984 ,top=614 ,right=1169 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940906' ,left=799 ,top=614 ,right=984 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='������' ,left=1355 ,top=614 ,right=1540 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940912' ,left=1169 ,top=614 ,right=1355 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940918' ,left=1540 ,top=614 ,right=1725 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='������' ,left=1725 ,top=614 ,right=1910 ,bottom=643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940302' ,left=58 ,top=643 ,right=243 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���' ,left=243 ,top=643 ,right=429 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ٵϱ��' ,left=614 ,top=643 ,right=799 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940901' ,left=429 ,top=643 ,right=614 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='������' ,left=984 ,top=643 ,right=1169 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940907' ,left=799 ,top=643 ,right=984 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�븮����' ,left=1355 ,top=643 ,right=1540 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940913' ,left=1169 ,top=643 ,right=1355 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940919' ,left=1540 ,top=643 ,right=1725 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��ǰ���' ,left=1725 ,top=643 ,right=1910 ,bottom=672 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���ǿ�' ,left=1725 ,top=672 ,right=1910 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='851101' ,left=1540 ,top=672 ,right=1725 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940914' ,left=1169 ,top=672 ,right=1355 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ĳ��' ,left=1355 ,top=672 ,right=1540 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940908' ,left=799 ,top=672 ,right=984 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����.����' ,left=984 ,top=672 ,right=1169 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940902' ,left=429 ,top=672 ,right=614 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ɲ��̱���' ,left=614 ,top=672 ,right=799 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��' ,left=243 ,top=672 ,right=429 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940303' ,left=58 ,top=672 ,right=243 ,bottom=701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940304' ,left=58 ,top=701 ,right=243 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=243 ,top=701 ,right=429 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�п�����' ,left=614 ,top=701 ,right=799 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940903' ,left=429 ,top=701 ,right=614 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��Ÿ�ڿ�' ,left=984 ,top=701 ,right=1169 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940909' ,left=799 ,top=701 ,right=984 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��������' ,left=1355 ,top=701 ,right=1540 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='940915' ,left=1169 ,top=701 ,right=1355 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='' ,left=1540 ,top=701 ,right=1725 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='' ,left=1725 ,top=701 ,right=1910 ,bottom=730 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<L> left=42 ,top=286 ,right=1921 ,bottom=286 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=545 ,top=193 ,right=675 ,bottom=241 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( ���� �Ǵ� �� )' ,left=1564 ,top=119 ,right=1902 ,bottom=167 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CYMD', left=1564, top=61, right=1902, bottom=108, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CO_NM', left=818, top=124, right=1204, bottom=172, face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CCHK6', left=143, top=183, right=540, bottom=251, face='����', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2782 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1511 ,top=3 ,right=1889 ,bottom=85</I>
	<L> left=42 ,top=0 ,right=1921 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>


">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 