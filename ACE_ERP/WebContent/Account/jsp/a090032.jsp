<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: �ڻ��Ѱ�ǥ
+ ���α׷� ID	: A090032.html
+ �� �� �� ��	: �ڻ���� ��ȸ ȭ��
+ ��  ��   �� : �� �� ��
+ �� �� �� �� : 2011.08.01
-----------------------------------------------------------------------------
+ �� �� �� �� : �ڻ��Ѱ����� ���� ( ������ ���� �� ���� )  
+ ��   ��   �� : ������
+ �� �� �� �� : 2011.10.12
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090032_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڻ��Ѱ�ǥ</title>
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
	gclx_fdcode.bindcolval = gs_fdcode;
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

    if (fn_trim(gcem_yymm.text)==""){ 
 
	    if(gcem_toyymm.text==""){
			alert("��ȸ����� Ȯ���Ͻʽÿ�");
			return;
		}
	
		if(gcem_byyyy.text==""){
			alert("����⵵�� Ȯ���Ͻʽÿ�");
			return;
		}
	
		if(gcem_cyyyy.text==""){
			alert("���⵵�� Ȯ���Ͻʽÿ�");
			return;
		}
	  	
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_s2"
										  + "?v_str1="+gclx_fdcode.BindColVal              //����
											+ "&v_str2="+gcem_toyymm.text                    //��ȸ���
											+ "&v_str3="+gcem_cyyyy.text                     //���⵵									
											+ "&v_str4="+gcem_byyyy.text;                    //����⵵ 
	  //prompt('', gcds_code01.DataID);				
		gcds_code01.Reset();
	}else{
	    alert(gcem_yymm.text.substring(0,4)+"�� "+gcem_yymm.text.substring(4,6)+"����  ����� �ڻ��Ѱ�ǥ��  ��ȸ�մϴ�.");
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_s4"
										  + "?v_str1="+gclx_fdcode.BindColVal         //����
										  + "&v_str2="+gcem_yymm.text                    //���س��								
	    //prompt('', gcds_code01.DataID);				
		gcds_code01.Reset();
	}
}

/******************************************************************************
	Description : ������ ��ȸ
******************************************************************************/
function ln_Query2(){
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_s3"
									  + "?v_str1="+gclx_fdcode.BindColVal              //����          
										+ "&v_str2="+gcem_toyymm.text   								 //��ȸ���      
										+ "&v_str3="+gcem_cyyyy.text                     //���⵵										
										+ "&v_str4="+gcem_byyyy.text;                    //����⵵      
  //prompt('', gcds_code02.DataID);				
	gcds_code02.Reset();

}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("�ڻ��Ѱ�ǥ","",2);
}


/******************************************************************************
	Description : ��� ���� �� �����ǿ� ���Ͽ� �ڻ��Ѱ�ǥ ���� 
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
		
		gctr_code01.KeyValue = "Account.a090032_t1(I:USER=gcds_astmmacht)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090032_t1";
	    gctr_code01.Parameters="v_str1="+gcem_toyymm.text+",v_str2="+gs_userid;		
	    //prompt('gcds_astmmccht',gcds_astmmccht.text);
		gctr_code01.post();
	}

}
/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_astmmacht.countrow<1){			
		var s_temp = "FDCODE:STRING(2),AST2ND:STRING(2),AST2NDNM:STRING(60),ASTYUSE:DECIMAL(5.2),BEFAQAMT:DECIMAL(13.0),"
                          + "CURAQAMT:DECIMAL(13.0),CLSAQAMT:DECIMAL(13.0),MOVAQAMT:DECIMAL(13.0),AQAMTSUM:DECIMAL(13.0),ABDEPRAMT:DECIMAL(13.0),"
                          + "ACDEPRAMT:DECIMAL(13.0),ACDEPRSUM:DECIMAL(13.0),REDUAMT:DECIMAL(13.0),DEAMTSUM:DECIMAL(13.0),JAAMTSUM:DECIMAL(13.0)";
		gcds_astmmacht.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ������ ���� 
******************************************************************************/
function ln_DataCopy(){
	gcds_astmmacht.ImportData(gcds_code01.ExportData(1,gcds_code01.CountRow,false));
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- ���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!-- �����ڻ꺰 �Ѱ� -->
<object  id=gcds_astmmacht  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<OBJECT id=gctr_code01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<param name="KeyName"			value="toinb_dataid4">
	</OBJECT>
</comment><script>__ws__(__NSID__);</script>

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

//	gcgd_disp01.Editable =true;

	if(gcds_code01.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}else{
		if (gcem_yymm.text==""){ 
			ln_Query2(); 
		}
	}
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">

	for(var i=1;i<=gcds_code01.countrow;i++){
		for(var j=1; j<=row;j++){
			if(gcds_code01.namevalue(i,"AST2ND")==gcds_code02.namevalue(j,"AST2ND")){
				gcds_code01.namevalue(i,"ABDEPRAMT")=gcds_code02.namevalue(j,"ABDEPRAMT");
				gcds_code01.namevalue(i,"ACDEPRAMT")=gcds_code02.namevalue(j,"ACDEPRAMT");
				gcds_code01.namevalue(i,"ACDEPRSUM")=gcds_code02.namevalue(j,"ACDEPRSUM");
				gcds_code01.namevalue(i,"REDUAMT")=gcds_code02.namevalue(j,"REDUAMT");
			}
		}
	}

</script>


<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcem_toyymm event=onKillFocus()>
	
	if(gcem_toyymm.text!=""){
		gcem_cyyyy.text = gcem_toyymm.text.substring(0,4);
    	gcem_byyyy.text = gcem_cyyyy.text - 1 ;
	}
</script>


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
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090032_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_save.gif"	    style="cursor:hand;" onclick="ln_Save()"> 
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
				<param name=ListExprFormat	    value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="70px"  class="tab24"  bgcolor="#eeeeee" align=center>��ȸ���</td>  
	    <td width="100px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gcem_toyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
			<param name=Text					value="">
			<param name=Alignment     value=0>
			<param name=Border        value=true>
			<param name=Format        value="YYYY/MM">
			<param name=PromptChar    value="_">
			<param name=BackColor     value="#CCCCCC">
			<param name=InheritColor  value=false>
			</object></comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_toyymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>����</td> 
		<td class="tab24" >&nbsp;
		 <comment id="__NSID__">
			<OBJECT id=gcem_byyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:35px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="YYYY">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>���</td> 
		<td class="tab24" >&nbsp;
		 <comment id="__NSID__">
			<OBJECT id=gcem_cyyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:35px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="YYYY">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>���س��</td> 
		<td class="tab24" >&nbsp;
		 <comment id="__NSID__">
			<object  id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text					value="">
				<param name=Alignment      value=0>
				<param name=Border          value=true>
				<param name=Format           value="YYYY/MM">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_yymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
		</td>
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="False"> 
					<param name=TitleHeight   value="20">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<FC> Name='�ߺз�'  			  ID=AST2NDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	   SumBgColor=#C3D0DB sumtext=''       </FC>
					<FC> Name='����\\����'	  ID=ASTYUSE		    HeadAlign=Center HeadBgColor=#B9D4DC Width=35 	align=right    SumBgColor=#C3D0DB sumtext='��'     </FC>
					<G> Name='���ݾ�'         HeadAlign=Center HeadBgColor=#B9D4DC
						<C> Name='�������'		  ID=BEFAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='���ű����'	  ID=CURAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='���Ű����'	  ID=CLSAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90    align=right	 SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='�����ü��ü'	  ID=MOVAQAMT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='��'	                  ID=AQAMTSUM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90    align=right	 SumBgColor=#C3D0DB sumtext={sum(BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT)}   Value={BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT} </C>
					</G>
					<G> Name='�����󰢴����'   HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='��'			          ID=DEAMTSUM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right	 SumBgColor=#C3D0DB sumtext={sum(ABDEPRAMT+REDUAMT+ACDEPRAMT)}  Value={ABDEPRAMT+REDUAMT+ACDEPRAMT} </C>
						<C> Name='���⴩��'	  	  ID=ABDEPRAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	 SumBgColor=#C3D0DB sumtext='@sum'   </C>
						<C> Name='�ջ����մ���'	  ID=REDUAMT  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
                        <C> Name='���󰢺�'	  ID=ACDEPRAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right    SumBgColor=#C3D0DB sumtext='@sum'   </C>
					</G> 
                   <C> Name='��������'	          ID=JAAMTSUM  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right  SumBgColor=#C3D0DB sumtext={sum((BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT)-(ABDEPRAMT+REDUAMT+ACDEPRAMT))}   Value={(BEFAQAMT+CURAQAMT-CLSAQAMT-MOVAQAMT)-(ABDEPRAMT+REDUAMT+ACDEPRAMT)} </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
			<br> * ���س���� �� ����� �ڻ��Ѱ�ǥ�� ��ȸ��.
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 