package kr.co.imjk.util;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

public class Logger {
    static private Logger instance;       // The single instance
    static java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");
    static PrintWriter log;

    /**
     * 
     * @uml.property name="instance"
     */
    static synchronized public Logger getInstance() {
        if (instance == null) {
            instance = new Logger();
        }
        return instance;
    }

    
    private Logger() {
        init();
    }
    
    private void init() {
        
		String logFile =   ConfigFile.get("logger_file");

        try {
            log = new PrintWriter(new FileWriter(logFile, true), true);
        }
        catch (IOException e) {
            System.err.println("Can't open the log file: " + logFile);
            log = new PrintWriter(System.err);
        }
    }
    
    public static void log(String msg) {
        if(instance == null) instance = getInstance();
        log.println(df.format(new Date()) + ": " + msg);
    }
    
    public static void log(Throwable e, String msg) {
        if(instance == null) instance = getInstance();
        log.println(df.format(new Date()) + ": " + msg);
        e.printStackTrace(log);
    }
    
    public static void log(Throwable e) {
        if(instance == null) instance = getInstance();
        e.printStackTrace(log);
    }
}
