package Ehr.vlu.k.vluk040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUK040DAO extends AbstractDAO {
	/**
	 * VLUK040DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUK040DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	public void VLUK040_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 평가구조설정 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // 고과년월
				p_box.get("DPT_CD_SHR").replaceAll("-", ""),                      // 소속
				p_box.get("JOB_CD_SHR").replaceAll("-", ""),                      // 직위
				p_box.get("ENO_NO_SHR").replaceAll("-", ""),                      // 피고과자사번

		};
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK040_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                      // 고과년월
				p_box.get("DPT_CD_SHR").replaceAll("-", ""),                      // 소속
				p_box.get("JOB_CD_SHR").replaceAll("-", ""),                      // 직위
				p_box.get("ENO_NO_SHR").replaceAll("-", ""),                      // 피고과자사번
				p_box.get("ENO_NOH").replaceAll("-", ""),                         // 고과자
				p_box.get("EVA_SEQ").replaceAll("-", ""),                         // 차수
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK040_SAV(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_SAV");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNOH" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))
		        ,JSPUtil.rns(vo.get("EVASEQ" ))
		        ,JSPUtil.rns(vo.get("DEPTCD" ))
		        ,JSPUtil.rns(vo.get("DEPTNM" ))
		        ,JSPUtil.rns(vo.get("PAYGRD" ))
		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

	public void VLUK040_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK040_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNOH" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))
		        ,JSPUtil.rns(vo.get("EVASEQ" ))
		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

}
