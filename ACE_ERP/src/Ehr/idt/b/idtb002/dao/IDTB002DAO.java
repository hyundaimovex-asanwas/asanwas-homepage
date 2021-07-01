package Ehr.idt.b.idtb002.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTB002DAO extends AbstractDAO {
	/**
	 * IDTB002DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTB002DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 문서현황을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB002_SHR(CBox p_box) throws CException {

		
		
		String STR_YMD_SHR    = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR    = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String ENO_NM         = JSPUtil.rns(p_box.get("ENO_NM_SHR")); 							

		//System.out.println("p_box   =========================================== " + p_box);
        
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_SHR");

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				//JSPUtil.rns(p_box.get("CEF_DOC_SHR")),				
                //JSPUtil.rns(p_box.get("ENO_NM_SHR"))
				ENO_NM
                
        };

		
		/** 조회 조건(사용일자)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.FROM_YMD >= '"+STR_YMD_SHR+"' ");
			sb.append("AND A.FROM_YMD <= '"+END_YMD_SHR+"' \n");
		}


        
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		//prop.add("CEF_STS", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("CET_NO", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		this.selectProcessFirstRow(sql, bind, prop);
		
		
	}




	/**
	 * 문서 발급 정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB002_INS(GauceValueObject vo, CBox p_box) throws CException {

		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_INS");

		
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("vo"+vo.toString());	  		
		
		String YYMM   = JSPUtil.rns(p_box.get("vcurdate").replaceAll("-", "")).substring(0,6);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				YYMM,
				YYMM,
				JSPUtil.rns(vo.get("ENO_NM")),    	// 이름
				JSPUtil.rns(vo.get("CD_GBN")),    	// 					
				JSPUtil.rns(vo.get("FROM_YMD")),    // 계약시작
				JSPUtil.rns(vo.get("TO_YMD")),    	// 계약끝
				JSPUtil.rns(vo.get("MONTH")),     	// 계약개월수
				JSPUtil.rns(vo.get("P01_AMT")),		// 
				JSPUtil.rns(vo.get("P02_AMT")),		// 
				JSPUtil.rns(vo.get("P03_AMT")),		// 	
				JSPUtil.rns(vo.get("P04_AMT")),		// 
				JSPUtil.rns(vo.get("P05_AMT")),		// 
				JSPUtil.rns(vo.get("SUM_AMT")),		// 			
				
			};

			/** INSERT메소드 호출  **/
			insertProcess(sql, bind);
		}

	

	/**
	 * 문서 정보를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTB002_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("ENO_NM")),    	// 이름
				JSPUtil.rns(vo.get("CD_GBN")),    	// 			
				JSPUtil.rns(vo.get("FROM_YMD")),    // 계약시작
				JSPUtil.rns(vo.get("TO_YMD")),    	// 계약끝
				JSPUtil.rns(vo.get("MONTH")),     	// 계약개월수
				JSPUtil.rns(vo.get("P01_AMT")),		// 
				JSPUtil.rns(vo.get("P02_AMT")),		// 
				JSPUtil.rns(vo.get("P03_AMT")),		// 	
				JSPUtil.rns(vo.get("P04_AMT")),		// 
				JSPUtil.rns(vo.get("P05_AMT")),		// 
				JSPUtil.rns(vo.get("SUM_AMT")),		// 		
				JSPUtil.rns(vo.get("SID")),			// SID		
				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	
	/**
	 * 문서 정보를 삭제하는  DAO메소드.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void IDTB002_DEL(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTB002_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SID"))
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	
	
}
