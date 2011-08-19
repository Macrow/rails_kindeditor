KindEditor.ready(function(K) {
	K.create('#kindeditor_id', {
		width: "100%",
		allowFileManager: true,
		langType: "zh_CN",
		uploadJson: '/kindeditor/upload',
		fileManagerJson: '/kindeditor/filemanager'
	});
});