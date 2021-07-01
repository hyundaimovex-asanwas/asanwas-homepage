package Ehr.wel.n.weln040.wrk;

import Ehr.wel.n.weln040.dao.WELN040DAO;

import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.POIUtil;

public class WELN040WRK {

	/**
	 * 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void WELN040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** WELJ010DAO 객체 생성 후 관련 메소드 호출 */
		WELN040DAO dao = new WELN040DAO("default", p_tr);
		dao.WELN040_SHR(p_box);

	}



}

