<!--
***********************************************************************
* @source      : misb010_ED.jsp
* @description : 이직율현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11     방석호        최초작성.
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
String GBN_SHR     = request.getParameter("GBN_SHR");  //급여,상여
String GBN_PRT_SHR = request.getParameter("GBN_PRT_SHR");  //직위,소속별

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

    /** 외부 XML에서 SQL을 읽어 온다 **/
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
    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
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
           // hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
           for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
           }
           hnwExtQuery.SendData(response);

       }

%>
