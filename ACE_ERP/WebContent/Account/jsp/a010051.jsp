<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ��ü��Ͻ���  
+ ���α׷� ID	: a010051.jsp
+ �� �� �� ��	: ��ü��Ͻ���   
+ �� �� �� ��	: 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ �� �� �� ��  : �ݼۻ��� �߰� 
+ ��   ��  ��  :  ������
+ �� �� �� ��  : 2013.04.01
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010051_s1, a010051_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;



/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    
    gclx_status_0.bindcolval ="N";
    
    gcra_usegb_0.codevalue="1";
   // gcra_use_tag_0.codevalue ="Y";	
    //gcra_use_tag.codevalue ="Y";	  
    
   // txt_empno.value =gusrid;
	//txt_empnmk.value = gusrnm;
  
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="+gcem_vend_id_0.text    
                                                                        +"&v_str5="   	
                                                                        +"&v_str6="+gcra_usegb_0.codevalue;     	
	                                                                                                                                                                                                                                        
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Apply(){

	if(!ln_Chk_Status()){
		return;
	}else if (gcds_data.IsUpdated) {
		if (confirm("��ü ����� ���� �Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
		}	
	}
}


/******************************************************************************
	Description : �ݼ�
******************************************************************************/
function ln_SendBack(){
	if(!ln_Chk_SendBack_Status())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("��ü ����� �ݼ� �Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t2";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
		}	
	}
}



/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/

function ln_Chk_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			
			
			if(gcds_data.namevalue(i,"STATUS")!="R"){
				alert("���� ��� ���� �ƴմϴ�.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="Y"; 
			}
			
			vcnt+=1;
		}
	}
	
	if(vcnt==0){
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	
	
	 //ȭ��󿡼� ���ϰ� üũ 
  	 for(var k =1; k<=gcds_data.countrow;k++){
  	 	for(var j=k+1;j<=gcds_data.countrow;j++){
  	 	    //alert("k::"+k+"::j::"+j+"::"+gcds_data.namevalue(k,"VEND_ID")+":::"+gcds_data.namevalue(j,"VEND_ID"));
   	 		if(gcds_data.namevalue(k,"CHK")=="T"&& gcds_data.namevalue(j,"CHK")=="T" && gcds_data.namevalue(k,"VEND_ID")==gcds_data.namevalue(j,"VEND_ID")){
   	 		    alert(gcds_data.namevalue(k,"VEND_ID")+"  ������ ����� ��ȣ�� ���� �մϴ� .");
   	 			return false;
   	 		}
   	    }
  	 }
  	 
  	 
  	 //DB �󼼼� ���ϰ� üũ 
  	 for(var p =1; p<=gcds_data.countrow;p++){
		if(gcds_data.namevalue(p,"CHK")=="T"){
			
			//�ؿܰŷ�ó -- ��Ϲ�ȣ ����. F �ŷ�ó ������ �ߺ� üũ 
			//����          -- ��Ϲ�ȣ ����. K �ŷ�ó ��ȣ�� �ߺ� üũ 
			//�� �� �Ϲ��� ����ڵ�Ϲ�ȣ //�ֹι�ȣ�� �ߺ� üũ 
			if(gcds_data.namevalue(p,"VEND_CD").substring(0,1)=="F"){
				
				gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s66?v_str1="+gcds_data.namevalue(p,"VEND_CD").substring(0,1); 
				gcds_temp01.Reset();
				
				if(gcds_temp01.namevalue(1,"CNT")>0){
					alert("�ߺ��� ��ȣ�� �����մϴ�1.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
					return false;
				}	
			}else if(gcds_data.namevalue(p,"VEND_CD").substring(0,1)=="K"){
				gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s66?v_str1="+gcds_data.namevalue(p,"VEND_CD").substring(0,1); 
				gcds_temp01.Reset();
				
				if(gcds_temp01.namevalue(1,"CNT")>0){
					alert("�ߺ��� ��ȣ�� �����մϴ�2.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
					return false;
				}	
			}else {
				gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s6?v_str1="+gcds_data.namevalue(p,"VEND_ID"); 
				gcds_temp01.Reset();
				
				if(gcds_temp01.namevalue(1,"CNT")>0){
					alert(gcds_data.namevalue(p,"VEND_ID")+" �ߺ��� ��ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
					return false;
				}	
			}	
		}
	}
	
	
  	 
	
	return true;
}




/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/

function ln_Chk_SendBack_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="R"){
				alert("�ݼ� ��� ���� �ƴմϴ�.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="B"; 
			}
			vcnt+=1;
		}
	}
	
	if(vcnt==0){
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	
	return true;
}


<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Save(){

	//if(!ln_Chk()) return;

	if (gcds_data.IsUpdated ){
		if (confirm("�����Ͻðڽ��ϱ� ?")) {
		  
			gctr_pyo.KeyValue = "Account.a010051_t3(I:USER=gcds_data)";
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010051_t3";
            gctr_pyo.Parameters="v_str1="+gusrid;

			gctr_pyo.post();
		}
	}
}


<%
/******************************************************************************
	Description : üũ  
******************************************************************************/
%>
function ln_Chk(){

/*
   // �ŷ�ó �ڵ� �� ������ üũ 
      for (var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"VEND_CD")==""){
			alert( i + "���� �ŷ�ó �ڵ带 Ȯ�� �ϼ���");
			return false;
		}
    }
    */
       
	return true;

}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_usegb_format(strusegb){
	if(strusegb=="1"){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(strusegb=="2"){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
}


/******************************************************************************
	Description : Dataset Head ���� -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
							+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
							+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
							+ "USE_TAG:STRING,"
							+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
							+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
							+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING"
							+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
}

function link_1(url){  // default â
  var stat='top=0,left=50,width=1024,height=768,toolbar=1,location=1,status=1,menubar=1,scrollbars=1,directories=0,resizable=1';

  newWin=window.open('','',stat);
  newWin.location=url;
}

<%
//���� �ٿ�
%>
function fnFileDown(intno){
	
	//alert("gcds_data.rowposition:::"+gcds_data.rowposition);
	var strReal_file="";
	var strSys_file="";
	
	
	if(gcds_data.rowposition<0){
		alert("�ش� �ŷ�ó�� �����Ͻʽÿ�.");
		return false;
	}
	
	
	if(intno==4){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE4")==""){
			alert("����ڵ������ ÷�������� �������� �ʽ��ϴ�.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE4");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE4");
		}
	}else if(intno==3){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE3")==""){
			alert("���ε�� ÷�������� �������� �ʽ��ϴ�.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE3");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE3");
		}
		
	}else if(intno==2){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2")==""){
			alert("�ϳ������� ÷�������� �������� �ʽ��ϴ�.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE2");
		}
	}else if(intno==1){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE1")==""){
			alert("��Ÿ�� ÷�������� �������� �ʽ��ϴ�.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE1");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE1");
		}
	}
	
	
	
	location.href ="./a010050_fileDownload.jsp?dir=&filename="+strReal_file+"&sysfilename="+strSys_file; //�
	
	
	/*
	var real_fileList="";
	var fileHtml="";				
	var real_fileList =txt_real_file.value;
	var real_file10= new Array();		
	
	real_file10 = real_fileList.split(":");	//�迭�� ����
	
	var real_file1=real_file10.slice(0,1);
	
	
	if(real_file1==""){
		alert("÷�������� �������� �ʽ��ϴ�")
		return;
	}else if(real_file1.length==1){
		location.href ="./a500010_fileDownload.jsp?dir=&filename="+real_file1+"&sysfilename="+real_file1; //�
		
	}
	*/
	
}	



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 
</comment><script>__ws__(__NSID__);</script>


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
   	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
    document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for="gcds_data" event="onloadCompleted(row,colid)" >//�� ��ȸ �Ǽ�
    var icnt=0;

   	if(gcds_data.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
		ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_data.RealCount(1,row) + " ��";
	}else {
	  	ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_data.RealCount(1,row) + " ��";
	}
 
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
		gcem_vend_id.Format = "000-00-00000";            //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";     //�ֹ� 
		gcem_vend_id.Format = "000000-0000000";        //�ֹ�
	}
</script>

<script language="javascript" for="gcgd_pyo" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

        //��û�͸� ��ü ���� �ǰ� ��.
        if(gcds_data.namevalue(1,"STATUS")!="R"){
        	alert("���ο�û �Ǹ� ��ü ���� �����մϴ�.");
        	return false;
        }
	
		if(gcds_data.namevalue(1,"CHK")=="T"){
		  	for(i=1;i<=gcds_data.countrow;i++){
       		 	gcds_data.namevalue(i,"CHK")="F";
		 	}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
       		 	gcds_data.namevalue(i,"CHK")="T";
		 	}
		}
	}
</script>




<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
  <tr> 
    <td ><img src="../img/a010051_head.gif"></td>
    <td width="688" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif"	style="cursor:hand" onclick="ln_Apply()" >
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sendbak.gif"	style="cursor:hand" onclick="ln_SendBack()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:878px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="100px;" bgcolor="#eeeeee" align="center">�ŷ�ó�ڵ�</td>
			<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
				<param name=Text				    value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td width="200px" class="tab24" align="left" ><comment id="__NSID__">
				<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
				<param name=Text			        value="">
				<param name=Alignment		    value=0>
				<param name=Border			    value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab14" >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-23px;top:2px;font-size:12px;width:100px;">
						<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
						<param name=CBDataColumns	     value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			     value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
			
		</tr>
		<tr> 
		<td class="tab27" width="100px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
		<td width="220px" class="tab11" ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:240px;height:20px" >
				<param name=Cols		value="3">
				<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ,3^����">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">��ȣ</td>
		<td width="90px" class="tab11"   Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
			<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
				<param name=Text		   value="">
				<param name=Alignment      value=0>
				<param name=Border         value=true>
				<param name=Numeric        value=false>
				<param name=Format         value="000-00-00000">
				<param name=PromptChar     value="">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor   value=false>
				<param name=readOnly       value=false>
		   </object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">&nbsp;</td>
		<td class="tab11" ><nobr> &nbsp;
			<a href="Javascript:link_1('https://teht.hometax.go.kr/websquare/websquare.html?w2xPath=/ui/ab/a/a/UTEABAAA13.xml')"><font color="blue"><b>����ڰ������� ��ȸ����</b></font></a>
		</td> 	 
		</tr> 
	</table>
	</td>
	</tr>

	<tr>
	<td colspan=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:876px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:876px;HEIGHT:322px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"		  VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"    VALUE="0">
						 <PARAM NAME="Indwidth"		  VALUE="0">
						 <PARAM NAME="Fillarea"		  VALUE="true">
						 <PARAM NAME="ColSizing"	  VALUE="true">
						 <param name="sortview"       value=left>
						 <param name="Editable"       value='true'>
						 <param name=UsingOneClick    value="1">
					     <PARAM NAME="Format"		  VALUE="  
					        <FC>ID=CHK 	         Name='����'             Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center  	EditStyle=CheckBox   </C>  
							<G> Name=�ŷ�ó����         HeadBgColor=#B9D4DC
							<FC>ID=VEND_CD,	     Name=�ڵ�,		        width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=160,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none, sort=true</FC>
							<C> ID=COCOMYN,	     Name=��ü����,	        width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true EditStyle=Combo, Data='N:�Ϲݾ�ü,T:���̰�����ü,M:�鼼��ü', show = true </C>
							<C> ID=VD_DIRECT,	 Name=��ǥ��,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=BSNS_CND,	 Name=����,	            width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=BSNS_KND,	 Name=����,	            width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							</G>
							<C> ID=REMARK,   	 Name=���,	            width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=EMPNMK,	     Name=�ۼ���,	            width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=STATUS		 Name=����,			    width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none, sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
							<C> ID=SB_REASON,    Name=�ݼۻ���,	        width=100,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE4,   Name=����ڵ����,        width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE3,   Name=���ε,         width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE2,   Name=�ϳ�����,         width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=REAL_FILE1,   Name=��Ÿ,             width=130,    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
					 <fieldset style="position:relative;left:0px;width:878px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
				</td>
			  </tr>
			 </table>
			</td>
		 </tr>
		</table>
  </td>	
  </tr>		
  </table>

  <table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td  ><b><font size="2" color="blue">[�ݼۻ��� ���]</font></b></td>
          <td align=right  >
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Save()">
		  </td>
    </tr>
  </table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>�ŷ�ó</td>
		<td width="350px"  class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:50px;height:20px;" readOnly >
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:180px;height:20px;" readOnly>&nbsp;&nbsp;
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:3px;width:90px;height:20px;">
				<param name=Text              value="">
				<param name=Alignment	    value=1>
				<param name=Border	        value=True>
				<param name=Format	        value="000-00-00000">
				<param name=PromptChar	value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor    value=false>
				<param name=ReadOnly      value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center>�ݼۻ���</td>
		<td width="310px"  class="tab24" >&nbsp;
			<comment id="__NSID__">
			<input id="txt_sb_reason" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:280px;height:20px;" maxlength="50" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='30px'>
          <td colspan=2 ><b><font size="2" color="blue">[÷������]</font></b></td>
    </tr>
    
    <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>����ڵ����</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file4' id="txt_real_file4" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('4')" >
			</nobr> 
		</td>
	</tr>
	 <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>���ε</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file3' id="txt_real_file3" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('3')" >
			</nobr> 
		</td>
	</tr>
	 <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>�ϳ�����</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file2' id="txt_real_file2" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('2')" >
			</nobr> 
		</td>
	</tr>
	 <tr>
		<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>��Ÿ</nobr></td>
		<td class="tab18" style="text-align:left"><nobr>
			<input type="text" name='txt_real_file1' id="txt_real_file1" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('1')" >
			</nobr> 
		</td>
	</tr>
</table>


    
<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_data">
<PARAM NAME="BindInfo" VALUE="
	<C>Col=VEND_CD		  Ctrl=txt_vend_cd		Param=value</C>
	<C>Col=VEND_NM		  Ctrl=txt_vend_nm		Param=value</C>
	<C>Col=VEND_ID		  Ctrl=gcem_vend_id	    Param=Text</C>
	<C>Col=SB_REASON      Ctrl=txt_sb_reason  	Param=value</C>
	<C>Col=REAL_FILE4     Ctrl=txt_real_file4  	Param=value</C>
	<C>Col=REAL_FILE3     Ctrl=txt_real_file3  	Param=value</C>
	<C>Col=REAL_FILE2     Ctrl=txt_real_file2  	Param=value</C>
	<C>Col=REAL_FILE1     Ctrl=txt_real_file1  	Param=value</C>
	
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



