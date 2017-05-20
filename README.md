##校友录系统

这是一个用于学习JSP的练习程序
数据库采用hsqldb，在运行时，也可改用如下方式获得连接

> //直接获得In-process连接
> String path = DBManage.class.getResource("").toString();
> String dbpath = path.substring(0,path.indexOf("classes")) + "db/alumni";
> 
> conn = DriverManager.getConnection("jdbc:hsqldb:"+dbpath,"SA","");