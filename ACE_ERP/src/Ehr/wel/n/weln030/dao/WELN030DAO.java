package Ehr.wel.n.weln030.dao;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class WELN030DAO extends AbstractDAO {
	/**
	 * WELN030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public WELN030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 정보 SELECT를 수행하는 DAO 메소드
     * @param p_box
     * @throws CException
     */
    public void WELN030_SHR(CBox p_box) throws CException {

        /** 외부 XML에서 정보 조회 SQL 읽음 **/
        String sql = XmlSqlUtils.getSQL("wel", "WELN030_SHR");


        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // 결재년월
        //        p_box.get("ENO_NO"),                // 사번
        };

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

    }

	/**
	 * 정보를 삭제하는 DAO메소드.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void WELN030_DEL(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // 결재년월
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	public void WELN030_DEL2(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_DEL2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // 결재년월
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int WELN030_SAV(GauceValueObject vo, CBox p_box) throws CException {

		//복지카드업로드 테이블 저장(dsT_CM_WELCARD)
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_SAV");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("SEQID")),
				JSPUtil.rns(vo.get("RESINO")),
				JSPUtil.rns(vo.get("ENO_NM")),
				JSPUtil.rns(vo.get("APPDT")),
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // 결재년월
				JSPUtil.rns(vo.get("SALAMT")),
				JSPUtil.rns(vo.get("MEMBER")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),

		};

		/** UPDATE메소드 호출  **/
		return updateProcess(sql, bind);
	}


	/**
	 * 정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int WELN030_SAV_01(GauceValueObject vo, CBox p_box) throws CException {


		//복지카드업로드 테이블 저장(dsT_CM_WELCARD)
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_SAV_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // 결재년월

		};

		/** UPDATE메소드 호출  **/
		return updateProcess(sql, bind);
	}

	/**
	 * 정보를 마감하는 DAO메소드.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void WELN030_SAV_END(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("wel", "WELN030_SAV_END");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
                p_box.get("PIS_YM_SHR").replaceAll("-", ""),                // 결재년월
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


}
