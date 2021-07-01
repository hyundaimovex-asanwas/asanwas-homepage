<!--
***********************************************************************
* @source      : taxa131_2_ED.jsp
* @description : 주민세특별징수명세서(상여)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      방석호        최초작성.
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
	DynamicValueObject voList = null;
	DynamicValueObject vo = null;


	String PIS_YY = request.getParameter("PIS_YYMM").substring(0,4);
	String PIS_MM = request.getParameter("PIS_YYMM").substring(4,6);
	String DPT_CD = request.getParameter("DPT_CD");

	String dpt_nm = null;
	String dpt_seq = null;
	String key = ""; //키값

	int eno_cnt = 0;

	int eno_tot_1 = 0;
	int eno_tot_2 = 0;
	int eno_tot_3 = 0;

	//소계
	long incm_tax = 0;
	long citi_tax = 0;

	//총합
	long incm_tot_1 = 0;
	long incm_tot_2 = 0;
	long incm_tot_3 = 0;

	long citi_tot_1 = 0;
	long citi_tot_2 = 0;
	long citi_tot_3 = 0;


		String sql = XmlSqlUtils.getSQL("tax2", "TAXA131_PRT2");
		  Object[] bind = new Object[]{
				PIS_YY,
	    		PIS_MM,
	    		DPT_CD,
	    };


		  AbstractDAO aaa= new AbstractDAO("default");
		  voList = aaa.selectProcessDvo(sql, bind);

		  extquery hnwExtQuery = new extquery();


		    hnwExtQuery.AddField("DPT_NM");
		    hnwExtQuery.AddField("DPT_SEQ");
		    hnwExtQuery.AddField("GBN");
		    hnwExtQuery.AddField("ENO_NO");
		    hnwExtQuery.AddField("INCM_TAX");
		    hnwExtQuery.AddField("CITI_TAX");

		    hnwExtQuery.AddField("BIGO");
		    hnwExtQuery.AddField("ENO_NM");
		    hnwExtQuery.AddField("NUM");



		    hnwExtQuery.SendField(response);



		    int i=0;

		    if (voList.size() > 0)
		    {

		        while(true) {

		            vo = (DynamicValueObject)voList.get(i);


		            //소계를 만듭시다.
		            if(!key.equals("")
		            		&& !key.equals(vo.getString("DPT_NM")+(vo.getString("GBN").equals("3") ? "2" : vo.getString("GBN")))) {


		                hnwExtQuery.AddData(dpt_nm);
		                hnwExtQuery.AddData(dpt_seq);
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(incm_tax));
		                hnwExtQuery.AddData(String.valueOf(citi_tax));

		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(eno_cnt)+"명");
		                hnwExtQuery.AddData("소계");

		                hnwExtQuery.SendData(response);

		                //값들 초기화
		                incm_tax = 0;
		                citi_tax = 0;
		                eno_cnt = 0;

		            }


		            //키 만들기
		            key = vo.getString("DPT_NM")+(vo.getString("GBN").equals("3") ? "2" : vo.getString("GBN"));
		            dpt_nm = vo.getString("DPT_NM");
		            dpt_seq = vo.getString("DPT_SEQ");


		            hnwExtQuery.AddData(vo.getString("DPT_NM"));
		            hnwExtQuery.AddData(vo.getString("DPT_SEQ"));
		            hnwExtQuery.AddData(vo.getString("GBN"));
		            hnwExtQuery.AddData(vo.getString("ENO_NO"));
		            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
		            hnwExtQuery.AddData(vo.getString("CITI_TAX"));

		            hnwExtQuery.AddData(vo.getString("BIGO"));
		            hnwExtQuery.AddData(vo.getString("ENO_NM"));
		            hnwExtQuery.AddData(vo.getString("NUM"));

		            hnwExtQuery.SendData(response);


		            //값 더하기
		            incm_tax += new Long(vo.getString("INCM_TAX")).longValue();
		            citi_tax += new Long(vo.getString("CITI_TAX")).longValue();

		            eno_cnt++;


		            //총합을 종류별로 구하기
		            if(vo.getString("GBN").equals("1")) {
		            	incm_tot_1 += new Long(vo.getString("INCM_TAX")).longValue();
		                citi_tot_1 += new Long(vo.getString("CITI_TAX")).longValue();

		                eno_tot_1++;
		            }
		            else if(vo.getString("GBN").equals("2")) {
		            	incm_tot_2 += new Long(vo.getString("INCM_TAX")).longValue();
		                citi_tot_2 += new Long(vo.getString("CITI_TAX")).longValue();

		                eno_tot_2++;
		            }
		            else if(vo.getString("GBN").equals("3")) {
		            	incm_tot_3 += new Long(vo.getString("INCM_TAX")).longValue();
		                citi_tot_3 += new Long(vo.getString("CITI_TAX")).longValue();

		                eno_tot_3++;
		            }





		            if(i+1 == voList.size()) {

		                //마지막 소계를 만듭시다.
		                if(eno_cnt != 0) {


		                    hnwExtQuery.AddData(dpt_nm);
		                    hnwExtQuery.AddData(dpt_seq);
		                    hnwExtQuery.AddData(" ");
		                    hnwExtQuery.AddData(" ");
		                    hnwExtQuery.AddData(String.valueOf(incm_tax));
		                    hnwExtQuery.AddData(String.valueOf(citi_tax));

		                    hnwExtQuery.AddData(" ");
		                    hnwExtQuery.AddData(String.valueOf(eno_cnt)+"명");
		                    hnwExtQuery.AddData("소계");

		                    hnwExtQuery.SendData(response);

		                    //값들 초기화
		                    incm_tax = 0;
		                    citi_tax = 0;
		                    eno_cnt = 0;

		                }


		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData("999991");
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(incm_tot_1));
		                hnwExtQuery.AddData(String.valueOf(citi_tot_1));

		                hnwExtQuery.AddData("재직자");
		                hnwExtQuery.AddData(String.valueOf(eno_tot_1)+"명");
		                hnwExtQuery.AddData("총  계");

		                hnwExtQuery.SendData(response);


		                break;
		            }

		            i++;
		        }
		    }
		    hnwExtQuery.EndData(response);




%>
