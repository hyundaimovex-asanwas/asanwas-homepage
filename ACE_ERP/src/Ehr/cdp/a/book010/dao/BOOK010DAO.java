package Ehr.cdp.a.book010.dao;

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

public class BOOK010DAO extends AbstractDAO {

	/**
	 * BOOK010AO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BOOK010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}


	/**
	 * 도서구입신청 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR(CBox p_box) throws CException {

		
		System.out.print("p_box::::::::::::::::"+p_box);
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * 도서구입신청 디테일  조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/

		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * 도서구입신청번호  조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * 도서구입신청 신규 Master 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_INS(CBox p_box, GauceValueObject vo) throws CException {

        //System.out.println("p_box:::::::::::::::::::::"+p_box);

        //System.out.println("vo:::::::::::::::::::::"+vo); 
		
		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		        ,JSPUtil.rns(vo.get("RQST_REMARK" ))
                ,vo.get("DPT_CD")                 //소속개념이네...
                ,"R"
				,vo.get("ENO_NO")
				,vo.get("ENO_NO")
		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}



	/**
	 * 도서구입신청 신규 Detail 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_INS_02(CBox p_box, GauceValueObject vo) throws CException {

		//System.out.print(p_box);
		//System.out.print(vo);

		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_INS_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		        ,JSPUtil.rns(vo.get("RQST_SEQ" ))
		        ,JSPUtil.rns(vo.get("BOOK_NM" ))
		        ,JSPUtil.rns(vo.get("BOOK_PUL" ))
		        ,JSPUtil.rns(vo.get("BOOK_WRT" ))
		        ,JSPUtil.rns(vo.get("BOOK_QTY" ))
		        ,JSPUtil.rns(vo.get("BOOK_AMT" ))
		        ,JSPUtil.rns(vo.get("BOOK_REMARK" ))
				,p_box.get("vusrid")
				,p_box.get("vusrid")
		        ,JSPUtil.rns(vo.get("HOMEPAGE" ))
		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}



	/**
	 * 결재선 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BOOK010_SHR_APP(CBox p_box) throws CException {


		System.out.print(p_box);

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
    			JSPUtil.rns(p_box.get("REQ_NO")),    	
    			JSPUtil.rns(p_box.get("REQ_NO"))       			
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

		//return this.selectProcess(sql, bind, prop);

	}



	/**
	 * 결재선 정보 삭제
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_DEL2(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_DEL2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				 p_box.get("REQ_NO")
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}



	/**
	 * 결재선을 처음 지정한다.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_SAV_APP1(CBox p_box, GauceValueObject vo) throws CException {


		//System.out.print(vo);

		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SAV_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
                 JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("GUN_GBN"))
                ,JSPUtil.rns(vo.get("DPT_CD"))
                ,p_box.get("vusrid")
                ,p_box.get("REQ_NO")
                ,"R"
                ,JSPUtil.rns(vo.get("SEQ_NO" ))
                ,JSPUtil.rns(vo.get("ENO_NO" ))
                ,JSPUtil.rns(vo.get("JOB_CD" ))
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")

		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}


	/**
	 * 상신처리도 하면서 결재선을 다시 지정한다.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_SAV_APP2(CBox p_box, GauceValueObject vo) throws CException {


		//System.out.print(vo);

		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SAV_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
                 JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("GUN_GBN"))
                ,JSPUtil.rns(vo.get("DPT_CD"))
                ,p_box.get("vusrid")
                ,p_box.get("REQ_NO")
                ,"A"
                ,JSPUtil.rns(vo.get("SEQ_NO" ))
                ,JSPUtil.rns(vo.get("ENO_NO" ))
                ,JSPUtil.rns(vo.get("JOB_CD" ))
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")

		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}


	/**
	 * 도서구입신청 상태를 상신으로 바꾼다.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_UPT_MST(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_UPT_MST");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
                p_box.get("REQ_NO")
		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}






	/**

	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				 JSPUtil.rns(vo.get("STR_HOL_HOUR"))
		        ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
		        ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))
			    ,JSPUtil.rns(vo.get("STR_HOL_HOUR"))
		        ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
		        ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))
				,JSPUtil.rns(vo.get("STR_HOL_HOUR"))
		        ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
		        ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))

	            ,JSPUtil.rns(vo.get("STR_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("STR_HOL_MIN" ))
	            ,JSPUtil.rns(vo.get("END_HOL_HOUR"))
	            ,JSPUtil.rns(vo.get("END_HOL_MIN" ))

	            ,JSPUtil.rns(vo.get("REMARK"      ))
				,p_box.get("vusrid")
				,JSPUtil.rns(vo.get("HOL_YMD"     )).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("ENO_NO"      ))
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}



	/**
	 * 도서신청 삭제
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK010_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("HOL_YMD").replaceAll("-", ""),
				vo.get("ENO_NO"),
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}







    /**
     * 상신처리
     * @param p_box
     * @throws CException
     */
	public void BOOK010_UPT_APP(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK010_UPT_APP");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
	    Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("APP_YN" ))
                ,p_box.get("SESSION_ENONO")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_GBN"))
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	            ,JSPUtil.rns(p_box.get("SEQ_NO" ))
	    };

	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);

	    sql = XmlSqlUtils.getSQL("gun", "BOOK010_UPT_APP2");

	    bind = new Object[] {
	    		JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	    		,JSPUtil.rns(p_box.get("GUN_GBN"))
	    		,JSPUtil.rns(p_box.get("GUN_DPT"))
	    };

	    updateProcess(sql, bind);
	}






	public void BOOK010_UPT_HOL(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_UPT_HOL");

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
	    Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("APP_YN" ))
                ,p_box.get("SESSION_ENONO")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	    };
	    /** INSERT메소드 호출 * */
	    updateProcess(sql, bind);
	}


	/**
	 * 도서구입신청 팝업 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK010_SHR_11(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK010_SHR_11");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

}
