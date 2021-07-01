package Ehr.sag.b.sagb060.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGB060DAO extends AbstractDAO {

	/**
	 * SAGB060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGB060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 사번정보 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet SAGB060_SHR(String eno_no) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGB060_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                eno_no
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);

	}

    /**
     * 급상여처리상태 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet SAGB060_CHK_WORKLOG(CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("sag", "SAGB060_CHK_WORKLOG");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YM").substring(0, 4)
               ,p_box.get("PIS_YM").substring(5, 7)
               ,p_box.get("SAL_GBN")
               ,p_box.get("BON_NUM")
        };

        /**Query  실행 후 자료 결과값을 Return  **/
        return this.selectProcess(sql, bind, prop);

    }

    /**
	 * 변동지불공제File전송 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGB060_DEL(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGB060_DEL");
		Object[] bind = new Object[] {
					p_box.get("PIS_YM").substring(0, 4)
	               ,p_box.get("PIS_YM").substring(5, 7)
		};


			/** INSERT메소드 호출  **/
			insertProcess(sql, bind);
		}

	/**
	 * 변동지불공제File전송 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGB060_INS(CBox p_box, GauceValueObject vo, String WRK_SEQ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGB060_INS");

        vo.set("PIS_YY" , p_box.get("PIS_YM").substring(0, 4));
        vo.set("PIS_MM" , p_box.get("PIS_YM").substring(5, 7));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),						//직종 CODE
				vo.get("PIS_YY"),	//해당년도
				vo.get("PIS_MM"),	//해당월
				vo.get("ENO_NO"),						//사원번호
				vo.get("SAL_CD"),							//급여항목
				//SEQ조회를 위한
				vo.get("OCC_CD"),						//직종 CODE
				vo.get("PIS_YY"),	//해당년도
				vo.get("PIS_MM"),	//해당월
				vo.get("ENO_NO"),						//사원번호
				vo.get("AD_TAG"),							//수당/공제구분
				vo.get("AMOUNT"),						//금액
				vo.get("REMARK"),						//적용
				vo.get("DPT_CD"),							//부서 CODE
				vo.get("JOB_CD"),							//직위 CODE
				p_box.get("vusrid"),//입력자
				p_box.get("vusrid")	//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

    /**
     * 작업번호 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet SAGB060_SHR_01(CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("sag", "SAGB060_SHR_01");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YM").substring(0, 4)
               ,p_box.get("PIS_YM").substring(5, 7)
        };

        /**Query  실행 후 자료 결과값을 Return  **/
        return this.selectProcess(sql, bind, prop);

    }

}
