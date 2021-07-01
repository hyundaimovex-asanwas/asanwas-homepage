/*
 * CommUtil
 *
 * Version 1.0
 *
 * Date 2007-06-21
 *
 * Copyright
 *
 * Description 공통으로 사용되는 함수들 모음
 */
package Ehr.common.util;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;

public class CommUtil {

    /**
     * 결과 내역을 담은 DataSet을 생성시켜 반환 한다.
     * @param filedName
     * @param resultMsg
     * @return
     */
    public static GauceDataSet getResultDataSet(String filedName, String resultMsg) {
        GauceDataSet gds    = new GauceDataSet();
        GauceDataRow dsRow  = null;

        gds.addDataColumn(new GauceDataColumn(filedName, GauceDataColumn.TB_STRING, 12000));

        dsRow = gds.newDataRow();
        dsRow.addColumnValue(resultMsg);

        gds.addDataRow(dsRow);

        return gds;
    }
    /**
     * FRS 쪽 LibName
     * @return
     */
    public static String getFrsLibName() throws CException{
    	Configuration config = Configuration.getInstance();
		String libName = config.getString("framework.ms.frs.library");
    	return libName;
    }
    /**
     * 전표 첨부를 위한 html생성시 파일경로
     * @return
     */
    public static String getHtmlFilePath() throws CException{
    	Configuration config = Configuration.getInstance();
		String filePath = config.getString("framework.html.path.home");

    	return filePath;
    }
    /**
     * 전표 첨부를 위한 URL 경로
     * @return
     */
    public static String getHtmlUrlPath() throws CException{
    	Configuration config = Configuration.getInstance();
		String filePath = config.getString("framework.html.url.home");

    	return filePath;
    }

    /**
     * 전표 첨부를 위한 URL 경로
     * @return
     */
    public static String getEzgenLocaionDNS() throws CException{
    	Configuration config = Configuration.getInstance();
		String filePath = config.getString("framework.print.ezgen.locationDNS");

    	return filePath;
    }
}
