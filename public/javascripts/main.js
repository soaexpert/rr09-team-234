function arrayToString(ar, indent) {
	var ser = '';
	var pad = (indent ? indent : '');
	for (key in ar) {
		if (!ar[key] || ar[key].constructor != Function) {
			ser += pad + ' ' + key + ': ';
			if (ar[key] == null) {
				ser += 'null\n';
			} else if (typeof(ar[key]) == 'object') {
				ser += 'array()\n';
				ser += arrayToString(ar[key], pad + '--');
			} else {
				ser += ar[key] + '\n';
			}
		} else {
			//ser += pad + ' ' + key + ': function()\n';
		}
	}
	return ser;
}