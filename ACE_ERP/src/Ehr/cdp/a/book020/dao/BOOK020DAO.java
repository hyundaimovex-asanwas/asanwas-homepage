package Ehr.cdp.a.book020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK020DAO extends AbstractDAO {

	/**
	 * BOOK020AO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BOOK020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}





	/**
	 * 도서구입신청 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK020_SHR(CBox p_box) throws CException {


		String APP_YN_SHR = JSPUtil.rns(p_box.get("APP_YN_SHR"));

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK020_SHR");


		StringBuffer sb = new StringBuffer();

		if(!"".equals(APP_YN_SHR) ) {
			sb.append("AND DECODE(A.END_TAG, NULL, 'A', A.END_TAG) = '").append(APP_YN_SHR).append("'         \n");
		}

		Object[] sqlParam = new Object[] {
                sb.toString()
        };

        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("BOOK_YMD_SHR")
				,p_box.get("BOOK_YME_SHR")
				,p_box.get("DPT_CD")

		};

		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);


		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);


	}




















	/**
	 * 도서구입신청 디테일  조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK020_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		//System.out.println("SESSION_DIL_AUTHO = "+ p_box.get("SESSION_DIL_AUTHO"));


		//String DIL_AUTHO = p_box.get("SESSION_DIL_AUTHO");

		String sql = XmlSqlUtils.getSQL("cdp", "BOOK020_SHR_02");

		//if (DIL_AUTHO.equals("A") || DIL_AUTHO.equals("M")) {
		//	 	  sql = XmlSqlUtils.getSQL("gun", "BOOK020_SHR_021");
		//}


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		//		p_box.get("HOL_YMD").replaceAll("-", ""),
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * 휴일근무휴가신청 결재선 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNC090_SHR_01");
        // System.out.println(p_box);
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("GUN_YMD").replaceAll("-", ""),
				p_box.get("GUN_DPT"),
				p_box.get("GUN_GBN"),
				p_box.get("GUN_YMD").replaceAll("-", ""),
				p_box.get("GUN_DPT"),
				p_box.get("GUN_GBN")
		};

		prop.add("GUN_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN" , ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_TIME" , ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 도서구입신청 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK020_INS(CBox p_box, GauceValueObject vo) throws CException {


		System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		System.out.print(vo);


		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK020_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
                ,JSPUtil.rns(vo.get("RQST_REMARK"      ))
                ,p_box.get("SESSION_DPTCD")
                ,"R"
				,p_box.get("SESSION_ENONO")
				,p_box.get("SESSION_ENONO")
		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}

	/**
	 * 휴일근무휴가신청 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK020_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK020_UPT");

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
				,p_box.get("SESSION_ENONO")
				,JSPUtil.rns(vo.get("HOL_YMD"     )).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("ENO_NO"      ))
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 휴일근무휴가신청 삭제
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK020_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK020_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("HOL_YMD").replaceAll("-", ""),
				vo.get("ENO_NO"),
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}


	/**
	 * 결재선 정보 삭제
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK020_DEL2(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK020_DEL2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				 p_box.get("REQ_NO")
		};


		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 휴일근무휴가신청 결재선 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK020_SAV_APP(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 * */
		String sql = XmlSqlUtils.getSQL("gun", "BOOK020_SAV_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 * */
		Object[] bind = new Object[] {
                 JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", "")
                ,JSPUtil.rns(vo.get("GUN_GBN"))
                ,JSPUtil.rns(vo.get("GUN_DPT"))
                ,p_box.get("SESSION_ENONO")
                ,p_box.get("REQ_NO")
                ,JSPUtil.rns(vo.get("SEQ_NO" ))
                ,JSPUtil.rns(vo.get("ENO_NO" ))
                ,JSPUtil.rns(vo.get("JOB_CD" ))
                ,p_box.get("SESSION_ENONO")
                ,p_box.get("SESSION_ENONO")


		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);
	}

    /**
     * 결재선 지정
     * @param p_box
     * @throws CException
     */
	public void BOOK020_UPT_APP(CBox p_box) throws CException {


	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK020_UPT_APP");

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

	    sql = XmlSqlUtils.getSQL("gun", "BOOK020_UPT_APP2");
	    bind = new Object[] {
	    		JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	    		,JSPUtil.rns(p_box.get("GUN_GBN"))
	    		,JSPUtil.rns(p_box.get("GUN_DPT"))
	    };
	    updateProcess(sql, bind);
	}

	public void BOOK020_UPT_HOL(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK020_UPT_HOL");

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
	 * 5일여부 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BOOK020_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "BOOK020_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("HOL_YMD_SHR").replaceAll("-", "").substring(0,6),
				p_box.get("ENO_NO_SHR")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}
