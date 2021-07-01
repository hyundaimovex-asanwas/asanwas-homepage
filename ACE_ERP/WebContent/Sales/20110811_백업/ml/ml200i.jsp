<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ���� �鼼 ����ǰ �Է� / ��ȸ
 * ���α׷�ID 	: DF310I
 * J  S  P		: df310i
 * �� �� ��		: Df310I
 * �������		: ���� �鼼 ����ǰ �Է� / ��ȸ
 * [ �������� ][������] ����
 * [2010-09-25][�ɵ���] �ű� �ۼ�
 * [2010-10-18][�ɵ���] �� �޴�Ʈ�� ����
 * [2011-01-11][�ɵ���] �� �������� ����ȭ���̶�� �ϸ� �پ��� ��������� �����ؾ� �����̰���?
 * [2011-10-12][�ɵ���] ����, �ſ�ī��(EDI), �������Ա� 3���� �־�� �� 
 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	 
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String endDay = m_today.format(date.getTime());
    date.add(java.util.Calendar.DATE, -2);        
    String startDay = m_today.format(date.getTime());           

	   
	//��Ű�ҷ����� ����
	String v_login_name ="";
	String v_login_id = "";
	Cookie cookies[] = request.getCookies();
     if(cookies != null) {
          for(int i=0; i<cookies.length; i++){
               if(cookies[i].getName().equals("vusrid") ) {
                    v_login_id = cookies[i].getValue() ;	//=> cookie���� �� �����Ҷ� ���                             
               }
               if(cookies[i].getName().equals("vusrnm") ) {
                    v_login_name = cookies[i].getValue() ;	//=> cookie���� �� �����Ҷ� ���                             
               }
          }
     } 
	//��Ű�ҷ����� ��
%>


<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
	<script language="javascript">
		var div='';
        var c_pay_manage_no     = "";   //���� ������ȣ
        
        
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		div = 'init';
		fnInit(); 
	}

	function fnInit(){
   		sBgnDate.text='<%=startDay%>';
   		sEndDate.text='<%=endDay%>';
		
		cfStyleGrid(getObjectFirst("gr1"), "comn");
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=5&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML001&s_item1=Y";
        codeDs1.Reset();
		
	}


	function fnSelect() {
		v_job = "S";
		v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                + ",dsType=1"
	            + ",sBgnDate=" + sBgnDate.text
	            + ",sEndDate=" + sEndDate.text
	            + ",sTr_OrderNm=" + getObjectFirst("sTr_OrderNm").value
                + ",sTrGu=" + sTrGu.ValueOfIndex("detail", sTrGu.Index);

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml200I", 
            "JSP(O:DS_MAIN=ds1)",
            v_param);
        tr_post(tr1);
	}

	function fnApply() {
	}


	//�����˻� ��
	function fnOrdererPopup(){
	    var strURL = "<%=dirPath%>/Coopbiz/help/sy030h.jsp";
	    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	    var return_value = showModalDialog(strURL,arrParam,strPos); 
    	
		if(return_value!=undefined){
			var arrParam = return_value.split(";");
            getObjectFirst("sUserId").value = arrParam[0];
            getObjectFirst("sUserNm").value = arrParam[1];
		}
	}

	//��� ������ư ��ü
    function fnAccount() {
        var v_sel_cnt = 0;
        var v_account_amt = 0;
        var v_client_cd = "";
        var v_client_sid = 0;
        var v_pay_method ="00101000"; 	//������� ��Ʈ �迭^^ 
			        					//���θ���: ����, �ſ�ī��EDI, ������, �ſ�ī�� Online Direct(���� ������ ����)

        if(getObjectFirst("ds1").CountRow==0){
            alert("���� ��ȸ�� Ŭ���Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        for(var i=1; i<=getObjectFirst("ds1").CountRow; i++){
            if( getObjectFirst("ds1").NameValue(i, "JOB_SEL")=="T" ){
                v_sel_cnt++;
                v_account_amt += getObjectFirst("ds1").NameValue(i, "PAYING_AMT");
                v_client_cd = getObjectFirst("ds1").NameValue(i, "CLIENT_CD");
                v_client_sid = getObjectFirst("ds1").NameValue(i, "CLIENT_SID");
                
              
                if(getObjectFirst("ds1").NameValue(i, "PAYING_AMT")==0){
                    alert("������ �ݾ��� �Է��Ͻñ� �ٶ��ϴ�.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAYING_AMT");
                    return;
                }
                
                if(eval(getObjectFirst("ds1").NameValue(i, "PAYING_AMT"))>eval(getObjectFirst("ds1").NameValue(i, "ARREARS_AMT"))){
                    alert("������ �ݾ��� ���� �̳��� ���� �� ���� �ݾ��Դϴ�.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAYING_AMT");
                    return;
                }

				//������ ���ٰ� 1���̶� �ֹ��Ѿ��� �����ϴ� ���� �ƴϸ� ���̷�Ʈ �Ұ�
                if(getObjectFirst("ds1").NameValue(i, "PAYING_AMT")!=getObjectFirst("ds1").NameValue(i, "AMT_EXCH")){
					v_pay_method ="00101000"; 
                }               
            }
        }
        
        if(v_sel_cnt==0){
            alert("���õ� ������ �����ϴ�.");
            return;
        }
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var v_pay_manage_no ="";
        var v_pay_date = "<%=DateUtil.getCurrentDate(8)%>";	//���⼭ �Ա����� ����Ʈ ������ �غθ���..�쾾..;
        var v_pay_cd = "";
        var v_plan_pay_date = "";   //�Աݿ�������
        
        /**���� �׸�
         * arrParam[0]
         * 0 : ������� ��ü
         * 1 : ������ü (������)
         * 2 : �ſ�ī�� EDI
         * 3 : ��ǰ�ǰ���
         * 4 : �������Ա�
         * 5 : ��Ÿ��ü
         * 6 : �ſ�ī�� Online
         */

		//���θ���:����, �ſ�ī��EDI, ������, �ſ�ī�� Online ��
        arrParam[0] = v_pay_method;
        arrParam[1] = v_client_cd;
        arrParam[2] = v_account_amt;
        arrParam[3] = ds1.NameValue(ds1.RowPosition, "ORDER_GUBN");//�ŷ����� 
        
        arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";     //�ܸ����ȣ
        arrParam[5] = "<%=HDConstant.KCP_TERM_ID%>";    //������ü �� ������� �͹̳� ID
        arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP%>";  //������ü �� ������� ������ ��ȣ
        arrParam[7] = v_client_sid;                     //�븮�� Sid
        arrParam[8] = ds1.NameValue(ds1.RowPosition, "USER_NM");
        arrParam[9] = ds1.NameValue(ds1.RowPosition, "ORDER_NO");        // �ֹ���ȣ(���̷�Ʈ ������ ���̵�� ���)
//prompt("","<%=dirPath%>");
//prompt("",arrParam);
//alert(arrParam);

		//���⼭ ����â ��!
        arrResult = fnCreditPop_mall("<%=dirPath%>", arrParam);
//alert("arrResult : " + arrResult);	//���⼭�� ����� �޾ƿ��� �����Ա�����..

		//���� �� ���� ������ ������Ʈ �ϴ� �κ�.. 
        if(arrResult!=null && arrResult!=undefined){
            arrParam = arrResult.split(":");
            v_pay_cd = arrParam[0];			//040:1101180002	ī��edi�� ��� �̷��� �޾ƿ´�.
            v_pay_manage_no = arrParam[1];
            if(arrParam.length>2)
                v_plan_pay_date = arrParam[2];	//��������� ��
            
//alert("arrParam : " + arrParam + " v_pay_cd : " +  v_pay_cd + " v_pay_manage_no : " + v_pay_manage_no);
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_client_cd="+v_client_cd
                        + ",v_pay_manage_no="+v_pay_manage_no
                        + ",v_account_amt="+v_account_amt
                        + ",v_pay_date="+v_pay_date
                        + ",v_pay_cd="+v_pay_cd
                        + ",v_plan_pay_date="+v_plan_pay_date;
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_ML%>Ml200I",
                "JSP(I:DEFAULT=ds1)",
                v_param);
            tr_post(tr_save);

        }
    }

	function fnPayApply(pay_manage_no){
		alert("������� ������Ʈ");

   		var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
		   	        + ",v_pay_manage_no="+pay_manage_no
					;
	        				
		ln_TRSetting(tr1,
			   		"<%=dirPath%>/servlet/coopbiz.menu.df.Df310I",
		           	"JSP(I:DS1=ds1)",
   			        v_param);
		tr_post(tr1);
	}


    //���� ���� ��ȣ ����
    function fnGetManageNo(){
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
            "JSP(O:PAY_MANAGE_NO=ds_manage_no)",
            "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,v_client_cd=10135");
        tr_post(tr1);
    }

	//ī�� ������ �˾�
	function popReceipt(idx){
		var receiptURL ="http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + idx;
	   	window.open(receiptURL,"cardReceipt","width=386,height=760,top=0,left=0, scrollbars=1");
	}

	//����  �˾�
	function popConfirm(order_sid){
		var receiptURL ="http://com.hdasan.com/shop_statement.asp?order_sid=" + order_sid;
	   	window.open(receiptURL,"shopStatement","width=730,height=670,scrollbars=yes,toolbar=no,menubar=yes,location=no,directories=no,top=100,left=100,noresize");
	}
	
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>


<script language=javascript for="gr1" event="OnClick(Row,Colid)">
	//���� Ŭ������ ��
    if(Row==0) {
        if(Colid == "JOB_SEL"){
            for(var i=1; i<=ds1.CountRow; i++){
//            alert(getObjectFirst("ds1").NameValue(i,"REMAINED_DEPOSIT_AMT"));
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                
                if(getObjectFirst("ds1").NameValue(i, Colid)=="T")
                    getObjectFirst("ds1").NameValue(i, "PAYING_AMT")=getObjectFirst("ds1").NameValue(i, "ARREARS_AMT");
                else
                    getObjectFirst("ds1").NameValue(i, "PAYING_AMT")=0;
            }
        }else if(Colid == "PAYING_AMT"){
            for(var j=1; j<=ds1.CountRow; j++){
      	        // alert(getObjectFirst("ds1").NameValue(j,"PAYING_AMT"));
       	         ds1.NameValue(j, Colid) = ds1.NameValue(1, Colid);
           };
         }   
        return;
    }


    if(Colid=="JOB_SEL"){
		//���� Ŭ���̺�Ʈ 
        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T"){
            getObjectFirst("ds1").NameValue(Row, "PAYING_AMT")=getObjectFirst("ds1").NameValue(Row, "ARREARS_AMT");
//            getObjectFirst("ds1").NameValue(Row, "PAYING_AMT")=1001;
        }else{
            getObjectFirst("ds1").NameValue(Row, "PAYING_AMT")=0;
        };

	    if(getObjectFirst("ds1").NameValue(Row, "AMT_PAID")>getObjectFirst("ds1").NameValue(Row, "AMT_EXCH")){
	        alert("�ֹ��Ѿ׺��� �Աݾ��� �� �����ϴ�.�����Ͻ� �� �����ϴ�.");
	        ds1.Undo(ds1.RowPosition);
	    };
	};	
	
/*    if(Colid=="PAY_YN"){
		//�������� Y�� ī�� ������ �����ֱ�
		if(getObjectFirst("ds1").NameValue(Row, "PAY_YN")=="Y"){
			popReceipt(getObjectFirst("ds1").NameValue(Row, "VAN_IDX_NO"));
		}else{
	        alert("���������� �����ϴ�.");
		};
	};	*/
    
</script>

<script language=JavaScript for="gr1" event="OnRButtonUp(Row, Colid, xpos, ypos)">
	//������ư Ŭ���ϸ� ��â ��
 	popConfirm(ds1.namevalue(Row, "ORDER_SID"));	//�ֹ�sid
</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<script language="javascript" for="ds_manage_no" event="OnLoadCompleted(row)">
    if(row==0){
        c_pay_manage_no = "";
        return;
    }
    c_pay_manage_no = ds_manage_no.NameValue(row, "PAY_MANAGE_NO");
</script>

<script language=JavaScript for=sBgnDate event=OnKillFocus()>
   if( sBgnDate.Modified == true )
		sEndDate.text = sBgnDate.text;
</script>

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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

<script language="javascript" for="tr_save" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr_save.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr_save.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);

    fnSelect();
</script>

<script language="javascript" for="tr_save" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_manage_no classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/account.gif" style="cursor:hand" onClick="fnAccount()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>

		
				<tr height="35px">
					<td>
						<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
							<tr>
		                        <td align="center" width="90px" height="30px" class="text">�ŷ�����</td>
								<td align="left" bgcolor="#ffffff" >&nbsp;
									<%=HDConstant.COMMENT_START%>
									<object id=sTrGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=170 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^130">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="35px">
					<td>
						<table  border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor=#666666>
							<tr>
								<td align=left width=90 class="text">�ֹ�����</td>
								<td align=left bgcolor="#ffffff" width=300>&nbsp;
								     <%=HDConstant.COMMENT_START%>
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
									</object>
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align="center" width="90px" height="30px" class="text">�ֹ��ڸ�</td>       
								<td bgcolor=#ffffff  valign="middle">&nbsp;&nbsp;<input type=text name=sTr_OrderNm id=sTr_OrderNm class="textbox"></td>
							</tr>
						</table>
					</td>
				</tr>

                <tr>
                    <td height="10"></td>
                </tr>             
                <tr>
                    <td colspan="2">
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:360px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="True">
                        <param name="SuppressOption"    value="1">
                        <Param Name="UsingOneClick"     value="1">
                        <Param Name="AllShowEdit"       value="True">
                        <param name="ViewSummary"       value="1">
                        <Param Name="SortView"     value="Right">
                        <param name="Format"            value=" 
                            <FC> name='��ü��'       ID='JOB_SEL'        Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </FC>
                            <FC> name='NO'          ID='{CURROW}'       Width=30   edit=none align=center</FC>
							<C> name='�ŷ�����'		ID='ORDER_GUBN'	Width=60  align=center  show=true	Edit=none editstyle=lookup  data='codeDs1:detail:detail_nm' </C>
							<C> name='�ֹ���ȣ'    	ID='ORDER_NO'  	Width=85  align=center  show=true	Edit=none 	</C>
							<C> name='�ֹ�����'    	ID='ORDER_DATE'	Width=60  align=center  show=true	Edit=none 	</C>
							<C> name='�Ϸù�ȣ'    	ID='COL04'  	Width=55  align=center  show=false 	Edit=none</C>
							<C> name='�ֹ��ڸ�'   	ID='USER_NM'  	Width=60  align=center  show=true	Edit=none 	</C>
							<C> name='����ó1'      ID='MOBILE_NO'  Width=85  align=center  show=true	Edit=none 	</C>
							<C> name='��ǰ\\����'	ID='ITEM_CNT'  	Width=35  align=center  show=true	Edit=none decao=0	 	sumtext=@sum</C>
							<C> name='�ֹ��Ѿ�'		ID='AMT_EXCH'  	Width=70  align=center  show=true	Edit=none decao=0	align=Right 	sumtext=@sum</C>
                          <G> name='�Աݾ�'
                            <C> name='�Աݾ�'		ID='AMT_PAID'    Width=60   SumText=@sum Edit=none align=Right Decao=0</C>
                            <C> name='���Աݾ�'		ID='AMT_NOT_PAID'   Width=60  SumText=@sum Edit=none align=Right Decao=0</C>
                            <C> name='�̽��ξ�'		ID='AMT_ONLINE_DR'	Width=60  SumText=@sum Edit=none align=Right Decao=0</C>
                          </G>
                            <C> name='�̳���'		ID='ARREARS_AMT'    Width=60   SumText=@sum Edit=none align=Right Decao=0</C>
                            <C> name='������'		ID='PAYING_AMT'        Width=60   SumText=@sum Edit=Numeric Decao=0 align=Right</C>

							

                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
     <tr>
         <td>
         	<table width=100%>
         	  <tr>
         	  	<td valign=top width=50%>
		         �� �׸����� ���� ��Ŭ���ϸ�<br>
		         ���� �ش� �ֹ���ȣ�� ���� â�� ��ϴ�.
         	  	</td>
         	  	<td valign=top width=50%>
		         �� �¶���ī�� ���̷�Ʈ�� ���� <B>���װ���</B>�� �����մϴ�.<br>
         	  	</td>         	  	
         	  </tr>
         	</table>
         </td>
     </tr>
</table>




<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


