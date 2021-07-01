package Ehr.gun.f.gunf040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF040DAO extends AbstractDAO {
	/**
	 * GUND060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 월차관리  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF040_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF040_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),				
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),	
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),				
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),					
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),				
				p_box.get("PIS_YYYY"),
				p_box.get("PIS_YYYY"),	
				p_box.get("PIS_YYYY"),
				p_box.get("DPT_CD"),
		};
		

        prop.add("WRK_TIME_01",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_02",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_03",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_04",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_05",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_06",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_07",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_08",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_09",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_10",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_11",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("WRK_TIME_12",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

		
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	
	
	/**
	 * 직원 소속 조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF040_SHR_01(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF040_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),

		};
		

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	
	/**
	 * 연차발생관리  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF040_SHR_DTL(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF040_SHR_DTL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				p_box.get("ENO_NO"),		
				p_box.get("ENO_NO"),					
				p_box.get("PIS_YM"),	

		};
		
		
		
        prop.add("WRK_TIME"      ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
          
        
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	


	
	
	
}
