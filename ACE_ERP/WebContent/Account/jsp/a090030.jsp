<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	: �ڻ���Ȳ		
+ ���α׷� ID	: A090030.html
+ �� �� �� ��	: �ڻ� ������ ��Ȳ ��ȸ ȭ��
+ ��  ��   �� : �� �� ��
+ �� �� �� �� : 2011.06.22
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090030_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڻ���Ȳ</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_fdcode = gfdcode;
var gs_userid = gusrid;

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
	//�Ҽ��ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�ڻ�з�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	gclx_fdcode.bindcolval = gs_fdcode;
	gcrd_gubun.codevalue=1;
	gcrd_gubun2.codevalue=1;
	gcgd_disp01.ColumnProp("ASTRMAMT", "Show") = "false";
 }

/******************************************************************************
	Description : �����󰢳��ã��
****************************************************************************/
 function ln_Find_ym(){
	gcds_astym.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s2"
									+ "?v_str1="+gclx_fdcode.BindColVal    //����
	gcds_astym.Reset();
 }

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){


    if (fn_trim(gcem_yymm.text)==""){

	    if(gcrd_gubun2.codevalue==1){
			gcgd_disp01.ColumnProp("ASTRMAMT", "Show") = "false";
		}else{
	        gcgd_disp01.ColumnProp("ASTRMAMT", "Show") = "true";
		} 
	
	    ln_Find_ym();
	   	
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s1"
										  + "?v_str1="+gclx_fdcode.BindColVal             //����
											+ "&v_str2="+gclx_asdivcod.BindColVal           //�ڻ�з�
											+ "&v_str3="+gcrd_gubun.codevalue               //���� 
											+ "&v_str4="+txt_COSTCD.value                   //�����ڵ� 
											+ "&v_str5="+gcds_astym.namevalue(1,"ASTFYM")   //������ �����⵵+01��
											+ "&v_str6="+gcds_astym.namevalue(1,"ASTLYM")  //������ ������� 
	                                        + "&v_str7="+gcrd_gubun2.codevalue;             //��������
											
	   // prompt('1', gcds_code01.DataID);				
		gcds_code01.Reset();
	}else{
		
	     alert(gcem_yymm.text.substring(0,4)+"�� "+gcem_yymm.text.substring(4,6)+"����  ����� �ڻ���Ȳ�� ��ȸ�մϴ�.");
	
		//���س���� ���� �����ϸ� ������ ������ ��Ȳ ���� ��ȸ�Ѵ� .
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s4"
									    + "?v_str1="+gclx_fdcode.BindColVal             //����
										+ "&v_str2="+gclx_asdivcod.BindColVal         //�ڻ�з�
										+ "&v_str3="+txt_COSTCD.value                     //�����ڵ� 
                                        + "&v_str4="+gcem_yymm.text;                      //���س��
											
	    // prompt('2', gcds_code01.DataID);				
		gcds_code01.Reset();
		
	}
	
}


/******************************************************************************
	Description : ��� ���� �� �����ǿ� ���Ͽ� �ڻ���Ȳ ������. ( �ܾ׹����� �� ,) 
	
******************************************************************************/
function ln_Save(){

     if(ln_Trim(gcem_toyymm.text)==""){
     	alert("����� �Է��ϼž��մϴ�.");
     	return;
     }
     
    //alert("::"+gcem_toyymm.text+"::");
     

	//������ ���� üũ 
	
	
	ln_SetDataHeader();  //�����ͼ� ���� 
	
	ln_DataCopy();          //������ ���� 
	
	
	//���� ( ���� ������ ������ üũ�Ͽ� �����ϸ� �������. - ������ �� ��� �Է��ؾ��� . )  
	
	 if (confirm("�����Ͻðڽ��ϱ� ?")) {
		
		gctr_code01.KeyValue = "Account.a090030_t2(I:USER=gcds_astmmccht)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_t2";
	    gctr_code01.Parameters="v_str1="+gcem_toyymm.text+",v_str2="+gs_userid;		
	    //prompt('gcds_astmmccht',gcds_astmmccht.text);
		gctr_code01.post();
	}
}


/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_astmmccht.countrow<1){			
		var s_temp = "FDCODE:STRING(2),RCOSTCD:STRING(6),COSTCD:STRING(6),COSTNM:STRING(60),ATCODE:STRING(7),"
                          + "AST2ND:STRING(2),AST2NDNM:STRING(60),ASTAQAMT:DECIMAL(13.0),ABDEPRAMT:DECIMAL(13.0),"
                          + "ACDEPRAMT:DECIMAL(13.0),ACDEPRSUM:DECIMAL(13.0),ASTRMAMT:DECIMAL(13.0),REDUAMT:DECIMAL(13.0)";
		gcds_astmmccht.SetDataHeader(s_temp);
	}
}



/******************************************************************************
	Description : ������ ���� 
******************************************************************************/
function ln_DataCopy(){
	gcds_astmmccht.ImportData(gcds_code01.ExportData(1,gcds_code01.CountRow,false));
}



/******************************************************************************
	Description : ���� �˾�
	Parameter   : srow - grid�� row, strgb - 01: grid,  02:�˻�����
******************************************************************************/
function ln_Popup4(srow,strgb){

    var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="0030";//�����ڵ�
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

    strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

	 if(strgb=="02"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD.value = ln_Trim(arrParam[0]);
			txt_COSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD.value = "";	
			txt_COSTNM.value = "";
		}
	}
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("�ڻ���Ȳ","",2);
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel_2(){
	gcgd_crosstab.GridToExcel("������ �Ѱ�ǥ","",2);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+COSTNM+AST2NDNM">
</object>

<!-- ���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- �ڻ�з� -->
<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>

<!-- ���������ã�� -->
<object  id="gcds_astym" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object>

<!-- �Ѱ�ǥ Closs tab -->
<object classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 id=gcds_crosstab>
		<param name=Logical		value=true>
		<param name=DataID		value=gcds_code01> 
		<param name=GroupExpr	value="COSTNM,AST2NDNM,ABDEPRAMT:REDUAMT:ACDEPRAMT:ACDEPRSUM">
</object>

<!-- ���������� ���� -->
<object  id=gcds_astmmccht  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_code01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_code01.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}

	if(gcrd_gubun2.codevalue==1){
		gcgd_crosstab.DataID="gcds_crosstab";
	}else{
	  gcgd_crosstab.DataID="";
	}
</script>


<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.index=0;
</script>

<!-- �ڻ�з� (�˻�)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="��ü";
	gclx_asdivcod.index=0;
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>
	//document.all.LowerFrame.style.visibility="visible";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	if(row<1) return;
	ln_Find_ym();
  var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_astym.namevalue(1,"ASTFYM");     //��� 01��
	arrParam[1] = gcds_astym.namevalue(1,"ASTLYM");     //������ �������
	
	if(gcrd_gubun2.codevalue==1){       //������
		arrParam[2] = gcds_code01.namevalue(row,"COSTCD"); //�����ڵ� 
	}else if(gcrd_gubun2.codevalue==2){ //������������
    arrParam[2] = gcds_code01.namevalue(row,"RCOSTCD"); //�����ڵ� 
	}
	arrParam[3] = gcds_code01.namevalue(row,"COSTNM");  //������ 
	arrParam[4] = gcds_code01.namevalue(row,"FDCODE");  //���� 
	arrParam[5] = gcds_code01.namevalue(row,"AST2ND");  //�ߺз� 
  arrParam[6] = gcrd_gubun2.codevalue;                 //�������� 

	var strURL = "./a090030_popup.jsp";
	var strPos = "dialogWidth:702px;dialogHeight:560px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090030_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_excel.gif"	    style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  class="tab25" bgcolor="#eeeeee" align=center>����</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="70px"  class="tab24"  bgcolor="#eeeeee" align=center> �ڻ�з�</td>  
	    <td width="180px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>������</td> 
		<td class="tab24" >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
	
	<tr> 
		<td width="70px"  class="tab27"  bgcolor="#eeeeee" align=center >����</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:100">
					<param name=Cols	  value="2">
					<param name=Format	value="1^��ȭ,2^��ȭ">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="70px"  class="tab28"  bgcolor="#eeeeee" align=center >��������</td>
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun2 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
					<param name=Cols	  value="2">
					<param name=Format	value="1^������,2^��������">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="70px"  class="tab28"  bgcolor="#eeeeee" align=center >���س��</td>
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object  id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;">		
				<param name=Text					value="">
				<param name=Alignment      value=0>
				<param name=Border          value=true>
				<param name=Format           value="YYYY/MM">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_yymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
		</td> 
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:250px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="False"> 
					<param name=TitleHeight   value="30">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<C> Name='�ڻ�з�'			  ID=AST2NDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	 SumBgColor=#C3D0DB sumtext=''</C>
					<C> Name='������'				  ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=240	align=left	 SumBgColor=#C3D0DB sumtext=''</C>
					<C> Name='���ݾ�'			  ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='���⴩���'	    ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='�ջ�����'	    ID=REDUAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='���󰢾�'	    ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='�����\\(����+�ջ�+���)'  ID=ACDEPRSUM	HeadAlign=Center HeadBgColor=#B9D4DC  Width=100  	 align=right	   SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='��������'			  ID=ASTRMAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>		
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
<BR>
<b>[ ������ �Ѱ�ǥ ]</b>  

    <comment id="__NSID__">
		<object  id=gcem_toyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:500px;top:3px">		
		<param name=Text					value="">
		<param name=Alignment     value=0>
		<param name=Border        value=true>
		<param name=Format        value="YYYY/MM">
		<param name=PromptChar    value="_">
		<param name=BackColor     value="#CCCCCC">
		<param name=InheritColor  value=false>
		</object>
	</comment><script>__ws__(__NSID__);</script> 
	<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_toyymm', 'Text')" style="position:relative;width:20px;left:502px;cursor:hand;">  


     <img src="../../Common/img/btn/com_b_save.gif"	   style="cursor:hand;position:relative;left:500px;" onclick="ln_Save()"> &nbsp;&nbsp; 
     <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;position:relative;left:500px;" onclick="ln_Excel_2()"> 
	 <img src="../../Common/img/btn/com_b_print.gif"      style="cursor:hand;position:relative;left:500px;" onclick="rp_cross.preview()">
   <br>
	 <object classid=CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_crosstab  height=300 width=858 style="position:relative;left:4px;"  >
		<param name=DataID	      value="gcds_crosstab">
		<param name="IndWidth"		value='0'>
		<param name=viewsummary		value=2>
		<param name=ColSizing     value="true">
		<param name=Format	value='
			<C>ID=COSTNM	name="����"		width=150	HeadColor=#FF0000	 SumText="�հ�" </C>
			<G>name="�հ�"     Headbgcolor="#DBE2B5",
			<C>name="����"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(ABDEPRAMT)} SumText={sum(CrossTabSum(ABDEPRAMT))} SumBgColor="orange"</C>
			<C>name="�ջ�"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(REDUAMT)}   SumText={sum(CrossTabSum(REDUAMT))}   SumBgColor="orange"</C>
			<C>name="���"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(ACDEPRAMT)} SumText={sum(CrossTabSum(ACDEPRAMT))} SumBgColor="orange"</C>
			<C>name="����"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(ACDEPRSUM)} SumText={sum(CrossTabSum(ACDEPRSUM))} SumBgColor="orange"</C>
			</G>
			<R>
				<G>name=$xkeyname_$$	Color=#0000FF
					<C>ID=ABDEPRAMT_$$	name="����"	width=90	HeadColor=#990000 SumText={sum(ABDEPRAMT_$$)} SumBgColor="orange"</C>
					<C>ID=REDUAMT_$$	  name="�ջ�"	width=90	HeadColor=#990000 SumText={sum(REDUAMT_$$)} SumBgColor="orange"</C>
					<C>ID=ACDEPRAMT_$$	name="���"	width=90	HeadColor=#990000 SumText={sum(ACDEPRAMT_$$)} SumBgColor="orange"</C>
					<C>ID=ACDEPRSUM_$$	name="����"	width=90	HeadColor=#990000 SumText={sum(ACDEPRSUM_$$)} SumBgColor="orange"</C>
				</G>
			</R>
			'>
	</object> 
   <br>
<!--Report Componet-->
<object id="rp_cross" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
 	<param name="MasterDataID"		value="gcds_crosstab">
 	<param name="DetailDataID"		value="gcds_crosstab">
 	<param name="PaperSize"			  value="A4">
 	<param name="Landscape"			  value=true>
 	<param name="Format"			    value="

<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=101 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='�����ڻ� ������ �Ѱ�ǥ' ,left=8 ,top=13 ,right=2828 ,bottom=101 ,face='Tahoma' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=212 ,face='Arial' ,size=10 ,penwidth=1
	<O> left=545 ,right=923
		<C>id='{sum(ABDEPRAMT_$$)}', left=545, top=167, right=664, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{sum(ACDEPRAMT_$$)}', left=672, top=167, right=791, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{sum(ACDEPRSUM_$$)}', left=796, top=167, right=915, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=545 ,top=164 ,right=921 ,bottom=164 </L>
		<L> left=667 ,top=114 ,right=667 ,bottom=212 </L>
		<T>id='����' ,left=796 ,top=119 ,right=915 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���' ,left=672 ,top=119 ,right=791 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='����' ,left=545 ,top=119 ,right=664 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=791 ,top=114 ,right=791 ,bottom=212 </L>
		<L> left=545 ,top=114 ,right=921 ,bottom=114 </L>
		<C>id='xkeyname_$$', left=545, top=66, right=915, bottom=111, face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=545 ,top=61 ,right=921 ,bottom=61 </L>
		<L> left=921 ,top=61 ,right=921 ,bottom=212 </L>
		<L> left=545 ,top=212 ,right=921 ,bottom=212 </L>
	</O>
	<L> left=8 ,top=212 ,right=537 ,bottom=212 </L>
	<T>id='�հ�' ,left=8 ,top=167 ,right=127 ,bottom=212 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<L> left=8 ,top=164 ,right=537 ,bottom=164 </L>
	<T>id='����' ,left=405 ,top=119 ,right=534 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=267 ,top=119 ,right=397 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=130 ,top=119 ,right=259 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=8 ,top=66 ,right=127 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=114 ,right=537 ,bottom=114 </L>
	<T>id='�հ�' ,left=130 ,top=66 ,right=534 ,bottom=111 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=61 ,right=537 ,bottom=61 </L>
	<L> left=127 ,top=61 ,right=127 ,bottom=212 </L>
	<L> left=3 ,top=61 ,right=3 ,bottom=212 </L>
	<L> left=262 ,top=114 ,right=262 ,bottom=212 </L>
	<C>id='{sum(CrossTabSum(ACDEPRSUM))}', left=405, top=167, right=534, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
	<L> left=400 ,top=114 ,right=400 ,bottom=212 </L>
	<L> left=537 ,top=61 ,right=537 ,bottom=212 </L>
	<C>id='{sum(CrossTabSum(ABDEPRAMT))}', left=130, top=167, right=259, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
	<C>id='{sum(CrossTabSum(ACDEPRAMT))}', left=267, top=167, right=397, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<O> left=545 ,right=923
		<C>id='ABDEPRAMT_$$', left=545, top=3, right=664, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACDEPRAMT_$$', left=672, top=3, right=791, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACDEPRSUM_$$', left=796, top=3, right=915, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=667 ,top=0 ,right=667 ,bottom=50 </L>
		<L> left=791 ,top=0 ,right=791 ,bottom=50 </L>
		<L> left=921 ,top=0 ,right=921 ,bottom=50 </L>
		<L> left=545 ,top=50 ,right=921 ,bottom=50 </L>
	</O>
	<C>id='COSTNM', left=8, top=3, right=127, bottom=48, align='left', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='{CrossTabSum(ABDEPRAMT)}', left=130, top=3, right=259, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
	<C>id='{CrossTabSum(ACDEPRAMT)}', left=267, top=3, right=397, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>
	<C>id='{CrossTabSum(ACDEPRSUM)}', left=405, top=3, right=534, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=0 ,right=3 ,bottom=50 </L>
	<L> left=537 ,top=0 ,right=537 ,bottom=50 </L>
	<L> left=262 ,top=0 ,right=262 ,bottom=50 </L>
	<L> left=127 ,top=0 ,right=127 ,bottom=50 </L>
	<L> left=400 ,top=0 ,right=400 ,bottom=50 </L>
	<L> left=3 ,top=50 ,right=537 ,bottom=50 </L>
</B>


	">
</object>


</body>
</html>