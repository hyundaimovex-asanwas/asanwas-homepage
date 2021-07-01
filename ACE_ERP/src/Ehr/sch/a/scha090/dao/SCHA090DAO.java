package Ehr.sch.a.scha090.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SCHA090DAO extends AbstractDAO {
	/**
	 * PIRA060DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SCHA090DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}
	
	/**
	 * 학자금 신청기간 설정 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void SCHA090_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 학자금 신청기간 설정 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),				// 년도
				p_box.get("PIS_QQ")				// 분기
		};
		
		prop.add("PIS_YY",  ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("END_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PAY_YM",  ColumnProp.COLUMN_TYPE_STRING, 7, ColumnProp.CONSTRAINT_TB_NOTNULL);
        prop.add("PAY_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	
	public void SCHA090_SHR2(CBox p_box) throws CException {

		/** 외부 XML에서 학자금 신청기간 설정 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_SHR2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
     * 학자금 신청기간 설정 저장 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void SCHA090_INS(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 학자금 신청기간 설정 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_INS");
        
        String ymd[] = JSPUtil.rns(vo.get("STR_YMD")).split("-");
        int quarter = 0;
        int month = 0;
        try {
            month = Integer.parseInt(ymd[1]);
        } catch(Exception e) {
            month = 1;
        }
        
        quarter = ((month-1)/3)+1;
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
                String.valueOf(quarter),			//분기
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),		//신청시작일
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),		//신청종료일
				JSPUtil.rns(vo.get("PAY_YM").replaceAll("-", "")),		//지급년월
				JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),		//지급일자
				p_box.get("vusrid"),
				p_box.get("vusrid")
		};
		

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}
	
	/**
     * 학자금 신청기간 설정 수정 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void SCHA090_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 학자금 신청기간 설정 (수정) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_UPT");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),		//신청종료일
                JSPUtil.rns(vo.get("PAY_YM").replaceAll("-", "")),      //지급년월
                JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),     //지급일자
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
				JSPUtil.rns(vo.get("PIS_QQ")),			//분기
                JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),     //신청시작일
		};
		

		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}
	
	/**
     * 학자금 신청기간 설정 삭제 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void SCHA090_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 학자금 신청기간 설정 (삭제) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA090_DEL");
		
		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),			//년도
				JSPUtil.rns(vo.get("PIS_QQ")),			//분기
                JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),     //신청시작일
		};
		

		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}
	

}
