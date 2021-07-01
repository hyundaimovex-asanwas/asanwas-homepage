<!--
***********************************************************************
* @source      : taxa110_ED.jsp
* @description : 사업소세(종업원할)산출내역 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/04      이승욱        최초작성.
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
    String HEAD_TAG       	= request.getParameter("HEAD_TAG");
    String PIS_YYMM_A0      = request.getParameter("PIS_YYMM_A0").replaceAll("-","");
    String PIS_YYMM_A1F     = request.getParameter("PIS_YYMM_A1F").replaceAll("-","");
    String PIS_YYMM_A1T     = request.getParameter("PIS_YYMM_A1T").replaceAll("-","");
    String PIS_YYMM_M0     	= request.getParameter("PIS_YYMM_M0").replaceAll("-","");
    String PIS_YYMM_M1F     = request.getParameter("PIS_YYMM_M1F").replaceAll("-","");
    String PIS_YYMM_M1T     = request.getParameter("PIS_YYMM_M1T").replaceAll("-","");
    String PIS_YYMM_Y3      = request.getParameter("PIS_YYMM_Y3").replaceAll("-","");

    System.out.println(HEAD_TAG);
    
    String HEAD_CODE = "";
    
    if (HEAD_TAG.equals("0"))
   	{
	    HEAD_CODE = "XX";	
   	}
    else
    {
        HEAD_CODE = "ZZ";		
    }
    

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String Query = XmlSqlUtils.getSQL("tax", "TAXA110_SHR_PRT1");

    //StringBuffer sql_head_tag = new StringBuffer();

    //param binding 하기
      Object[] bind = null;
      bind = new Object[] {
    		  PIS_YYMM_A0,  PIS_YYMM_A0,  HEAD_CODE,    		  
    		  PIS_YYMM_A1F, PIS_YYMM_A1T, PIS_YYMM_A1F, PIS_YYMM_A1T,HEAD_CODE,
    		  PIS_YYMM_Y3,  PIS_YYMM_Y3,  HEAD_CODE,    		  
    		  PIS_YYMM_M0,  PIS_YYMM_M0,  HEAD_CODE,    		  
    		  PIS_YYMM_M1F, PIS_YYMM_M1T, PIS_YYMM_M1F, PIS_YYMM_M1T,HEAD_CODE,
    		  PIS_YYMM_Y3,  PIS_YYMM_Y3,  HEAD_CODE
    };


    if(!HEAD_TAG.equals("3")) {
    }

    //DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다
    Object[] sqlParam = new Object[] {
    };

    //[1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("BON_P_C1");
    hnwExtQuery.AddField("BON_P_1");
    hnwExtQuery.AddField("BON_B_C1");
    hnwExtQuery.AddField("BON_B_1");
    hnwExtQuery.AddField("BON_Y_C1");
    hnwExtQuery.AddField("BON_Y_1");
    hnwExtQuery.AddField("JI_P_C1");
    hnwExtQuery.AddField("JI_P_1");
    hnwExtQuery.AddField("JI_B_C1");
    hnwExtQuery.AddField("JI_B_1");
    hnwExtQuery.AddField("JI_Y_C1");
    hnwExtQuery.AddField("JI_Y_1");
    hnwExtQuery.AddField("SEU");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);            
            hnwExtQuery.AddData(vo.getString("BON_P_C1"));
            hnwExtQuery.AddData(vo.getString("BON_P_1"));
            hnwExtQuery.AddData(vo.getString("BON_B_C1"));
            hnwExtQuery.AddData(vo.getString("BON_B_1"));
            hnwExtQuery.AddData(vo.getString("BON_Y_C1"));
            hnwExtQuery.AddData(vo.getString("BON_Y_1"));
            hnwExtQuery.AddData(vo.getString("JI_P_C1"));
            hnwExtQuery.AddData(vo.getString("JI_P_1"));
            hnwExtQuery.AddData(vo.getString("JI_B_C1"));
            hnwExtQuery.AddData(vo.getString("JI_B_1"));
            hnwExtQuery.AddData(vo.getString("JI_Y_C1"));
            hnwExtQuery.AddData(vo.getString("JI_Y_1"));
            hnwExtQuery.AddData(vo.getString("SEU"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
