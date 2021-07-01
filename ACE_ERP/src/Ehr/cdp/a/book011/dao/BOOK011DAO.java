package Ehr.cdp.a.book011.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK011DAO extends AbstractDAO {

	/**
	 * BOOK011DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BOOK011DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 결재선 지정
     * @param p_box
     * @throws CException
     */
	public void BOOK011_UPT_APP(CBox p_box) throws CException {


	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_APP");
	    String seq_no = JSPUtil.rns(p_box.get("SEQ_NO"));

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("APP_YN" ))
                ,p_box.get("vusrid")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_GBN"))
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	            ,JSPUtil.rns(p_box.get("SEQ_NO" ))
	    };

	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);


	    if(seq_no.equals("1")){

		    sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_APP");

		    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		    bind = new Object[] {
	                 "R"
	                ,p_box.get("vusrid")
		            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
		            ,JSPUtil.rns(p_box.get("GUN_GBN"))
		            ,JSPUtil.rns(p_box.get("GUN_DPT"))
		            ,"2"
		    };
		    /** INSERT메소드 호출 * */
		    updateProcess(sql, bind);
	    }

	}



	/**
	 * 도서구입신청 Detail 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK011_UPT_DETAIL(CBox p_box, GauceValueObject vo) throws CException {


		System.out.print(p_box);
		System.out.print(vo);

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_UPT_DETAIL");

		Object[] sqlParam = new Object[] {

		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[]{

		        JSPUtil.rns(vo.get("BOOK_NM" ))
		        ,JSPUtil.rns(vo.get("BOOK_PUL" ))
		        ,JSPUtil.rns(vo.get("BOOK_WRT" ))
		        ,JSPUtil.rns(vo.get("BOOK_QTY" ))
		        ,JSPUtil.rns(vo.get("BOOK_AMT" ))
		        ,JSPUtil.rns(vo.get("BOOK_REMARK" ))
				,p_box.get("vusrid")
				,p_box.get("REQ_NO")
		        ,JSPUtil.rns(vo.get("RQST_SEQ" ))
			};

	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);


	}




	public void BOOK011_UPT_HOL(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_HOL");
	    String seq_no = JSPUtil.rns(p_box.get("SEQ_NO"));
	    String app_yn = JSPUtil.rns(p_box.get("APP_YN" ));
	    String gun_gbn = JSPUtil.rns(p_box.get("GUN_GBN"));

		StringBuffer sb = new StringBuffer();

	    if (gun_gbn.equals("R")) {
	    	sb.append("END_TAG");
	    } else if (gun_gbn.equals("H")) {
	    	sb.append("SIGN_TAG");
	    } else if (gun_gbn.equals("J")) {
	    	sb.append("CONF_TAG");
	    }

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[]{
		    	seq_no
		    	,app_yn
		    	,app_yn
	            ,p_box.get("vusrid")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
			};

	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);
	}





	public void BOOK011_UPT_REJ(CBox p_box) throws CException {


	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_REJ");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[] {
	             JSPUtil.rns(p_box.get("APP_YN" ))
	            ,p_box.get("vusrid")
	            ,JSPUtil.rns(p_box.get("REMARK"))
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_GBN"))
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	            ,JSPUtil.rns(p_box.get("SEQ_NO" ))
	    };

	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);
	}




	/**
	 * 결재 처리내용을 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK011_UPT(CBox p_box, GauceValueObject vo) throws CException {

		System.out.print(p_box);
		System.out.print(vo);


		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_UPT_NEW");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("APP_YN"),
				JSPUtil.rns(vo.get("REMARK")),				//비고 -> 필드전용  Container 역할t("REMARK"),
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("vusrid")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}





	/**
	 * 동일 등록번호의 결재한개수세기(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet BOOK011_CNT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_CNT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE메소드 호출  **/
		return selectProcess(sql, bind);
	}






	public void BOOK011_UPT_HOL_NEW(CBox p_box, String APP_YN ) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_UPT_HOL_NEW");


	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[]{
	    		 APP_YN
	            ,p_box.get("vusrid")
				,p_box.get("REQ_NO")
			};


	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);

	}





	public void BOOK011_UPT_HOL_NEW_H(CBox p_box, String APP_YN ) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_HOL_NEW_H");

	    String gun_gbn = JSPUtil.rns(p_box.get("GUN_GBN"));

		StringBuffer sb = new StringBuffer();

	    if (gun_gbn.equals("R")) {
	    	sb.append("END_TAG");
	    } else if (gun_gbn.equals("H")) {
	    	sb.append("SIGN_TAG");
	    } else if (gun_gbn.equals("J")) {
	    	sb.append("CONF_TAG");
	    }

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[]{
	    		 APP_YN
	            ,p_box.get("vusrid")
	            ,p_box.get("GUN_YMD").replaceAll("-", "")
	            ,p_box.get("GUN_DPT")
			};

	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);
	}
}