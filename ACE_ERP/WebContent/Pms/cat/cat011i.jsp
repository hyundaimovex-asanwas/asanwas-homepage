<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���� ���� / ������ü ��� ��ȸ
 * ���α׷�ID 	: cat011I computer added tender
 * J  S  P		: Pms/cat/cat011i.jsp
 * �� �� ��		: Cat011I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2017-07-05 
 * [��  ��   ��  ��][������] ����
 * [2017-06-27][�ɵ���] ���� �˻� �������� ��ȸ, �������� �߰��Է����� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

	//��¥ ����.
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
   String firsttime = m_today.format(date.getTime()).substring(8,12);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>

<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		//��ü���� �� : ��ȸ�����ϱ� ���ؼ�
			var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
			var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����		
	        v_job = "I";		
	        
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr_master"), "comn");
			cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
			fnInit(); 
		}

		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
			//sBgnDate.text="<%=firstday%>";
			//sEndDate.text="<%=firstday%>";
		    	   
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
            	"JSP(O:EXCELDS=tempExcelDs)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
        	
			//�����ڵ� �θ��� by �ɵ��� 
            codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT02&s_item1=Y";
            codeDs1.Reset();	//����
            codeDs2.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT03&s_item1=Y";
            codeDs2.Reset();	//��������
            codeDs3.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT04&s_item1=Y";
            codeDs3.Reset();	//����
            codeDs4.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=4&proType=S&s_Head=CAT01&s_item1=Y";
            codeDs4.Reset();	//��������

            
		}

		/**
		 * �������� 
		 * ���� ���ε� �Ŀ� ��ȸ 
		 */
		function fnExcelApply()  {
			v_job = "I";
			//alert("***"+sGubn1.ValueOfIndex("detail", sGubn1.Index)+"***");
			//alert("***"+file_path.value+"***");
			
			/*if(sGubn1.ValueOfIndex("detail", sGubn1.Index)==" ") {
				alert("�������� ���� ���¹�ȣ�� ������ �ּ���.");
				sGubn1.focus();
				return false;
			}*/
			if(file_path.value=="") {
				alert("���� ������ ã���ּ���.");
				file_path.focus();
				return false;
			}			
			
			tempExcelDs.addrow();
		 	
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_INFO") = file_path.value;
		 	tempExcelDs.namevalue(tempExcelDs.rowposition, "EXCEL_URL") = file_path.value;
		 
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",sGubn1=" + sGubn1.ValueOfIndex("detail", sGubn1.Index);
		 
			 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
                "JSP(I:TEMP_EXCEL=tempExcelDs,O:EXCELDS=excelDs,O:EXCELDSM=excelDsM)",
	            v_param);                

            tr_post(tr1);
		}
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			
			 v_job = "S";
        	 v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
		            + ",sBgnDate=" + sBgnDate.text
		            + ",sEndDate=" + sEndDate.text
		            + ",sTr_Sum=" + sTr_Sum.value
                    + ",sGubn1=" + sGubn1.ValueOfIndex("detail", sGubn1.Index);
                    
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I", 
	            "JSP(O:MAIN_DSM=excelDsM)",
	            v_param);
	        tr_post(tr1);
		}
		//��������ȸ
	    function fnSelectDetail(row) {
	    	if(row>excelDsM.countrow){	//�տ��� ���� row�� ds_cul���� ũ��, �� ���ο� �������� ds_cul�� ��ȸ�� ��
	    		row = 1;	//���� ������ ó��
	    	}
	        v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��

	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
	                    + ",v_ot_sid="+ excelDsM.namevalue(row,"OT_SID");
			ln_TRSetting(tr2, 
					"<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
	            "JSP(O:MAIN_DS=excelDs)",
	            v_param);
	        tr_post(tr2);
	    }

			
		/*
		 * ����
		 */
		function fnApply() {
			/*if(sGubn1.ValueOfIndex("detail", sGubn1.Index)=="") {
				alert("�����Ͻñ� ���� ���¹�ȣ�� ������ �ּ���.");
				sGubn1.focus();				
				return false;
			}*/
			
			if(excelDsM.namevalue(1,"GUBN01")==" "){
				alert("�߰� �Է� ���� - ���㸦 �����ؾ� ���� �����մϴ�.");
				return false;
			}
			if(excelDsM.namevalue(1,"GUBN02")==" "){
				alert("�߰� �Է� ���� - ���������� �����ؾ� ���� �����մϴ�.");
				return false;
			}
			if(excelDsM.namevalue(1,"GUBN03")==" "){
				alert("�߰� �Է� ���� - ������ �����ؾ� ���� �����մϴ�.");
				return false;
			}
			if(excelDsM.namevalue(1,"GUBN04")==" "){
				alert("�߰� �Է� ���� - ���������� �����ؾ� ���� �����մϴ�.");
				return false;
			}

			v_job = "A"; //����
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>";
			if (excelDs.IsUpdated&&excelDsM.IsUpdated) {
				 ln_TRSetting(tr1,
				  "<%=dirPath%><%=HDConstant.PATH_CAT%>Cat010I",
               	  "JSP(I:EXCELDSM=excelDsM,I:EXCELDS=excelDs,O:RESULT=ds_result)",
               	  param);
            	tr_post(tr1);
			} else {
				alert("������Ʈ�� ���� �����ϴ�.");
			};
		}
		
		/*
		 * ����
		 */
		function fnExcelDs1() {
			alert("�������Դϴ�.");
			/*			
	        if(excelDs.CountRow==0){
    	        alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
        	    return;
        	};
        	   
	        getObjectFirst("gr_detail").SetExcelTitle(0, "");
	        getObjectFirst("gr_detail").SetExcelTitle(1, "value:������ �ŷ�����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_detail").GridToExcel("Sheet1","������ �ŷ�����.xls", 8);
	        */
		}

		<%//ȸ�� �ŷ�ó ��ȸ�ϱ�%>
		function fnPopVC(dirPath,row){	
	   		var arrParam	= new Array();
	   		var arrResult	= new Array();
	   		var strURL;	 
	   		var strPos;
	   		var origin_bp_sid;
	   		var origin_bp_nm;
	   		var origin_bid_site_kind;
	   			
	   		arrParam[0] = "0020";
	   		arrParam[1] = "�Ϲ���";

	   		
	   		strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
			strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	   		arrResult = showModalDialog(strURL,arrParam,strPos);	

	   		if (arrResult != null) {
	   			arrParam = arrResult.split(";");
	   			excelDs.namevalue(excelDs.rowposition, "VEND_CD")  		= arrParam[0];//�ŷ�ó�ڵ�
	   			excelDs.namevalue(excelDs.rowposition, "VEND_NM")  		= arrParam[1];//�ŷ�ó��
	   		} else {
	   			excelDs.namevalue(excelDs.rowposition, "VEND_CD")  		= "Z";
	   			excelDs.namevalue(excelDs.rowposition, "VEND_NM")  		= "�Ϲ���";
	   		}				
	     	
		}
		<%//GRID �ʱ�ȭ%>
		function fnReset(){	
			excelDsM.ClearAll();
			excelDs.ClearAll();
		}
	   		
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<%//������ �׸��� OnClick : ����|�ͼ����� ��ȸ %>
	<script language="javascript"  for=gr_master event=OnClick(Row,Colid)>
		v_job="SD";
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			
			if(Colid=="OT_NO"||Colid=="OT_NM"||Colid=="ORDERER_NM"||Colid=="OT_DATE"||Colid=="AMT_BASE"||Colid=="AMT_WIN"){
				fnSelectDetail(Row);				
			}
	    }
	</script>
	
	<script language=JavaScript  for=excelDsM event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
			if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				fnSelectDetail(v_default_row);
			}
		}

		
	</script>


	<script language=JavaScript  for=excelDs event="OnLoadCompleted(row)">
		if (excelDs.countrow <= 0) {
			return;
		}
		
		if (v_job == "I"){//�׼�����
			for(i = 1; i <= excelDs.countrow; i++) {
				excelDs.namevalue(i, "OT_SID") = 5;
				excelDs.namevalue(i, "DT_SID") = 3;
			}			
			for(i = 1; i <= excelDsM.countrow; i++) {
				excelDsM.namevalue(i, "OT_SID") = 5;
			}			

		};
	</script>



	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';

        if(v_job=="I") {	// �׼������� ��.
	        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            //�޽��� ó��
	        /*for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);*/
        } else if(v_job == "H" || v_job=="S") {	// ��ȸ�� ��.
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	} else if(v_job == "A"){//�� �����
       		msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
       		fnSelect();	//����ȸ
       	}
        
	</script>
		

	<script language=JavaScript for=tr2 event=OnFail()>
	 var error_cnt = tr2.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
	
	</script>
	
	<script language=JavaScript for=tr1 event=OnFail()>
	 var error_cnt = tr1.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
	</script>

	<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
//		    	alert(gcip_file.value);
		    	file_path.value = gcip_file.value;
		    }
	</script>
	
	<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
	    if(ds_result.CountRow>0){
	        var v_result_msg = "";
	        for(var i=1; i<=ds_result.CountRow; i++){
	            if(ds_result.NameValue(i, "MSG_CD")!="0000")
	                v_result_msg += ds_result.NameValue(i, "MSG")+"\n";
	        }
	
	        if(v_result_msg!="")
	            alert(v_result_msg);
	    }
	</script>
	
		

	<%// �ŷ�ó �� %>	
	<script language=JavaScript for=gr_detail event=OnPopup(row,colid,data)>
		if(colid=="VEND_NM") {
			fnPopVC('<%=dirPath%>', row);
		}
	</script>

	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
	        if( sBgnDate.Modified == true )
	        	sEndDate.text = sBgnDate.text;
	</script>  	
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>

<object id=tempExcelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=excelDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=excelDsM classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	
									
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="845px">
					<tr>
						<td align="right" >
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcelDs1();"><br />&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td>
				<table  border="0" cellpadding="0" cellspacing="1" width="845px" bgcolor=#666666>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">����</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGubn1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^160">
							</object>
								
						</td>
                        <td align="center" width="90px" height="30px" class="text">��������</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGuBN2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs2>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
						</td>
                        <td align="center" width="90px" height="30px" class="text">����</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGubn3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs3>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
						</td>						
					</tr>
					<tr>
                        <td align="center" width="90px" height="30px" class="text">��������</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;				
							<object id=sGubn4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs4>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
						</td>
                        <td align="center" width="90px" height="30px" class="text">��������</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;<select name="sGubn5" id="sGubn5">
								<option value="0">��ü</option>
								<option value="101"> - �������� 100�� �̻�(����)</option>
								<option value="99"> - �������� 100��̸�(����)</option>
 
							</select>				

						</td>
						<td align="center" width="90px" height="30px" class="text">�����ȣ</td>
						<td align="left" bgcolor="#ffffff" >&nbsp;<input type=text name=sOT_NO id=sOT_NO style="width:160px;" class='textbox' ></td>	
					</tr>
					<tr>
						<td align=left width=90 class="text">������</td>
						<td align=left bgcolor="#ffffff" >&nbsp;
						     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">
							</object>&nbsp;~&nbsp;<object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">
								<param name=InheritColor      value="true">
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">
							</object>							
						</td>
						<td align="center" width="90px" height="30px" class="text">�����</td>       
						<td bgcolor=#ffffff  >&nbsp;<input type=text name=sOT_NM id=sOT_NMstyle="width:160px;" class='textbox' ></td>
						<td align="center" width="90px" height="30px" class="text">����ó</td>
						<td bgcolor=#ffffff  >&nbsp;<input type=text name=sORDERER_NM id=sORDERER_NM style="width:160px;" class='textbox' ></td>
					</tr>
				</table><br />
			</td>
		</tr>
		<tr height=2><td></td></tr>
		<tr>
			<td>
				<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master style="width:98%; height:180px" border="1">
				        <param name="DataID"            value="excelDsM">
				        <param name="BorderStyle"       value="0">
				        <param name="ColSizing"         value="true">
				       	<param name="IndWidth"  		value="20">
				        <param name="editable"          value="true">
				        <param name=SortView  			value="Left">
				        <param name="indwidth"			value="20">
				        <param name="Format"            value="
				        	<C> name='No.'    		ID='{CurRow}'		 width=30 	align=right edit=none </C>
				        <G>name='�׼� �ε� ����'
							<C> name='�����ȣ'    	ID='OT_NO' Width=90 </C>
				        	<C> name='�����'    	ID='OT_NM' 	Width=200  align=left  show=true 	edit=none</C>
				        	<C> name='����ó'  		ID='ORDERER_NM'    	Width=100  align=center  show=true	edit=none</C>
				        	<C> name='�����Ͻ�'    	ID='OT_DATE'    	Width=120  align=left  show=true	edit=none</C>
				        	<C> name='���ʱݾ�'  	ID='AMT_BASE'   	Width=100  align=RIGHT  show=true	DEC=0 edit=none</C>
				        	<C> name='1���� �����ݾ�' 	ID='AMT_WIN'  	Width=100  align=RIGHT show=true	DEC=0 edit=none</C>
						</G>
						<G>name='�߰� �Է� ����'
							<C> name='����'  	 	ID='GUBN01'   		width=60	align=CENTER	edit=true editstyle=lookup Data='codeDs1:detail:detail_nm'  </C>
							<C> name='��������'   	ID='GUBN02'   		width=90	align=CENTER	edit=true editstyle=lookup Data='codeDs2:detail:detail_nm'  </C>
							<C> name='����'  	 	ID='GUBN03'   		width=60	align=CENTER	edit=true editstyle=lookup Data='codeDs3:detail:detail_nm'  </C>
							<C> name='��������'  	ID='GUBN04'   		width=60	align=CENTER	edit=true editstyle=lookup Data='codeDs4:detail:detail_nm'  </C>
						</G>
							<C> name='����_SID'    	ID='OT_SID'  		Width=70	align=left  show=false	edit=none</C>
				        ">
				</object>
			</td>
		</tr>

		<tr height=10><td></td></tr>
		<tr height="100%">
			<td>
				<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_detail style="width:98%; height:300px" border="1">
				        <param name="DataID"            value="excelDs">
				        <param name="BorderStyle"       value="0">
				        <param name="ColSizing"         value="true">
				       	<param name="IndWidth"  		value="20">
				        <param name="editable"          value="true">
				        <param name=SortView  			value="Left">
				        <param name="indwidth"			value="20">
				        <param name="ViewSummary"       value="1">
				        <param name="Format"            value="
				                <C> name='����'					ID='OT_RANK'		Width=40 	align=center  show=true decao=0 edit=none sumtext=@cnt</C>
				                <C> name='��ü��'  				ID='COMPANY_NM'    	Width=130	align=center  show=true	edit=none sumtext='��'</C>
				                <C> name='����ڹ�ȣ'      		ID='BIZREGI_NO'    	Width=80	align=center  show=true	edit=none</C>
				                <C> name='��ǥ��'  				ID='EXC_MAN'   		Width=60	align=center  show=true	edit=none </C>
				                <C> name='�����ݾ�'  			ID='AMT_TENDER'  	Width=110	align=right		show=true	edit=none decao=0</C>
				                <C> name='�������\\������(%)'  ID='RATE_EXPECT'	width=70 	align=center	Edit=none 	 decao=4 </C>
				                <C> name='���ʴ��\\������(%)'  ID='RATE_BASE'		width=70 	align=center	Edit=none 	 decao=4 </C>
				                <C> name='���ʴ��\\������(%)'  ID='RATE_SHOOT'		width=70 	align=center	Edit=none 	 decao=4 </C>
			                	<C> name='�����Ͻ�'				ID='DATE_TENDER'   	Width=110	align=center 	show=true	edit=none</C>
				                <C> name='�������Ѱ�\\����(��)' ID='AMT_DIFF_MIN'  	Width=110	align=right		show=true	edit=none decao=0</C>
				                <C> name='���'    				ID='OT_REMARK'  	Width=110	align=left  show=true	edit=none</C>
				                <C> name='����_SID'    			ID='OT_SID'  		Width=50	align=left  show=false	edit=none</C>
				                <C> name='������_SID'    		ID='DT_SID'  		Width=50	align=left  show=false	edit=none</C>
				        ">
				</object>
			</td>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
		
	<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="tempExcelDs">
             <param name=BindInfo    value="
                <C>Col=EXCEL_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=EXCEL_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>		
      					

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

