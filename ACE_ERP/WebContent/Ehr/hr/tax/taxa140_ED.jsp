<!--
***********************************************************************
* @source         : taxa140_ED.jsp 				                                                                                     *
* @description   : ���ڱ�/����ݰ��� PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/03      ���м�        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    String PIS_YYMM  = request.getParameter("PIS_YYMM");
    String GMK_TAG   = request.getParameter("GMK_TAG");
    String SAL_GBN   = request.getParameter("SAL_GBN");
    String SEQ       = request.getParameter("SEQ");
    String OCC_CD    = request.getParameter("OCC_CD");
    String DPT_CD    = request.getParameter("DPT_CD");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("tax", "TAXA140_SHR");

    //DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ�
    Object[] sqlParam = new Object[] {

    };

    //[1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ�
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    //param binding �ϱ�
    Object[] bind = new Object[] {
				PIS_YYMM.replaceAll("-", "").substring(0,4),
				PIS_YYMM.replaceAll("-", "").substring(4,6),
				GMK_TAG,
				SAL_GBN,
				SEQ,
				OCC_CD,
				DPT_CD,
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�ٷα���");
    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ݾ�");

    if ( GMK_TAG.equals("0") ) {
        hnwExtQuery.AddField(" ");
    } else {
        hnwExtQuery.AddField("���� ��ȯ��");
    }
    hnwExtQuery.AddField("�հ�");
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            hnwExtQuery.AddData(i);
			hnwExtQuery.AddData(vo.getString("OCC_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("GMK_AMT"));
            if ( GMK_TAG.equals("0") ) {

                hnwExtQuery.AddData(vo.getString(""));
                hnwExtQuery.AddData(vo.getString("GMK_AMT"));
            } else {
                hnwExtQuery.AddData(vo.getString("GMK_INT"));
                hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("GMK_AMT")) + Integer.parseInt(vo.getString("GMK_INT"))));
            }

            hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");

        hnwExtQuery.SendData(response);
    }

%>