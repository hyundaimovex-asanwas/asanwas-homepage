package Ehr.yac.a.yaca040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA040DAO extends AbstractDAO {

	/**
	 * YACA040DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 기부금공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		//prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);

		//prop.add("REL_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("COM_NO", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("COM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("TOT_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 기부금공제 대사장 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR_05(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);

		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * 기부금공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 기부금공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 기부금공제 대사장 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR2_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR2_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 기부금공제 대사장 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA040_SHR2_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_SHR2_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * 기부금공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_INS(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
    
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
				dsArray[i][2],//REL_CD
				dsArray[i][4],//REMARK
				dsArray[i][5].replaceAll("-", ""),//COM_NO
				dsArray[i][6],//COM_NM
				dsArray[i][7],//TOT_CNT
				dsArray[i][8],//SUM_AMT
				dsArray[i][10],//FAM_CD
				dsArray[i][11],//FAM_NM
				dsArray[i][12],//FAM_NO
				dsArray[i][13],//NTS_YN				
				p_box.get("vusrid"),					//입력자
				p_box.get("vusrid")					//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	
	/**
	 * 기부금공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_INS_14(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_INS_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
    
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
				dsArray[i][2],//REL_CD
				dsArray[i][3],//REMARK
				dsArray[i][4].replaceAll("-", ""),//COM_NO
				dsArray[i][5],//COM_NM
				dsArray[i][6],//TOT_CNT
				dsArray[i][7],//SUM_AMT
				dsArray[i][8],//FAM_CD
				dsArray[i][9],//FAM_NM
				dsArray[i][10],//FAM_NO
				dsArray[i][11],//NTS_YN				
				p_box.get("vusrid"),					//입력자
				p_box.get("vusrid")					//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * 기부금공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_INS_15(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_INS_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
    
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
				dsArray[i][2],//REL_CD
				dsArray[i][3],//REMARK
				dsArray[i][4].replaceAll("-", ""),//COM_NO
				dsArray[i][5],//COM_NM
				dsArray[i][6],//TOT_CNT
				dsArray[i][7],//SUM_AMT
				dsArray[i][8],//FAM_CD
				dsArray[i][9],//FAM_NM
				dsArray[i][10],//FAM_NO
				dsArray[i][11],//NTS_YN				
				p_box.get("vusrid"),					//입력자
				p_box.get("vusrid")					//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	

	
	/**
	 * 기부금공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속녀도
				vo.get("ENO_NO"),							//사원번호
				vo.get("REL_CD"),								//기부유형
				vo.get("REL_CD"),								//기부유형
				vo.get("COM_NO").replaceAll("-", ""),	//사업자등록번호
				vo.get("REL_CD"),								//기부유형
				vo.get("FAM_NO"),								//주민등록번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	
	public void YACA040_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속녀도
				vo.get("ENO_NO"),							//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	
	
	
	/**
	 * 기부금공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_DEL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),							//사원번호
				vo.get("REL_CD"),								//기부유형
				vo.get("REL_CD"),								//기부유형
				vo.get("COM_NO").replaceAll("-", ""),	//사업자등록번호
				vo.get("REL_CD"),								//기부유형
				vo.get("FAM_NO"),								//주민등록번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * 기부금공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_DEL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),							//사원번호
				vo.get("REL_CD"),								//기부유형
				vo.get("REL_CD"),								//기부유형
				vo.get("COM_NO").replaceAll("-", ""),	//사업자등록번호
				vo.get("REL_CD"),								//기부유형
				vo.get("FAM_NO"),								//주민등록번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	
	public void YACA040_DEL_ALL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_ALL_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),							//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}		
	
	public void YACA040_DEL_ALL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_DEL_ALL_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),							//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}		
	
	
	
	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_FAM(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_FAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_ACC(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}

	
	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_FAM_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_FAM_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_FAM_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_FAM_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	

	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_RET_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_RET_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_ACC_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속년도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * 기부금 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA040_UPT_ACC_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA040_UPT_ACC_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속년도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	
}
