<!--
***********************************************************************
* @source      : misb010_ED.jsp
* @description : ��������Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11     �漮ȣ        �����ۼ�.
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
String TOT_YY      = request.getParameter("TOT_YY");
String SHR_YY      = request.getParameter("SHR_YY");
String STR_MM      = request.getParameter("STR_MM");
String END_MM      = request.getParameter("END_MM");
String GBN_SHR     = request.getParameter("GBN_SHR");  //�޿�,��
String GBN_PRT_SHR = request.getParameter("GBN_PRT_SHR");  //����,�ҼӺ�

    String NXT_YY = SHR_YY;
    String NXT_MM = null;

    if (END_MM.equals("12"))
    {
        NXT_YY = SHR_YY;
        NXT_MM = "12";

    }else{
        NXT_YY = SHR_YY;
        int iMonth = Integer.parseInt(END_MM);
        NXT_MM = Integer.toString(iMonth);
        if (NXT_MM.length() == 1)
        {
            NXT_MM = "0" + NXT_MM;
        }
    }

    String sql = null;

    /** �ܺ� XML���� SQL�� �о� �´� **/
    if (GBN_PRT_SHR.equals("0"))
    {
        sql =XmlSqlUtils.getSQL("mis", "MISB020_SHR_01");
    }
    else
    {
        sql =XmlSqlUtils.getSQL("mis", "MISB020_SHR_02");
    }

    Object[] bind = new Object[] {
    		TOT_YY,
    		SHR_YY,
    		STR_MM,
            END_MM,
    		GBN_SHR,

            TOT_YY,
            GBN_SHR,
            SHR_YY,
            STR_MM,
            END_MM,
            GBN_SHR,
            NXT_YY,
            NXT_MM,
            GBN_SHR
    };
    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
       String     colStr  =   "SUB_NM,SUM_TOT,SUM_CNT,SUM_TERM,SUM_CNT2,SUM_TERM2,SUM_CNT3,DPT_SEQ,GROUP_SEQ";

       String[] values = colStr.split(",");
       for( int x = 0; x < values.length; x++ ){
           hnwExtQuery.AddField(values[x]);
       }
    hnwExtQuery.SendField(response);

       if (voList.size() > 0)
       {
           for (int i=0; i<voList.size(); i++)
           {
               DynamicValueObject vo = (DynamicValueObject)voList.get(i);

               for( int x = 0; x < values.length; x++ ){
                   hnwExtQuery.AddData(vo.getString(values[x]));
               }
               hnwExtQuery.SendData(response);
           }
       }
       else
       {
           // hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
           for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
           }
           hnwExtQuery.SendData(response);

       }

%>
