#bootstrap-waitingfor

"Waiting for..." modal dialog with progress bar for Bootstrap.

See this plugin in action:rocket:: http://bootsnipp.com/snippets/featured/quotwaiting-forquot-modal-dialog

##Features

* AMD-compatible
* Configurable

##Using

You can install this module with bower `bower install bootstrap-waitingfor` and include the files from `build` directory.

In your javascript code write something like this:
```js
waitingDialog.show('I\'m waiting');
setTimeout(function () {
  waitingDialog.hide();
}, 1000);
```

See `src/waitingfor.js` for additional options.

##Contributing

Before making a pull request do the following steps:

1. Run `gulp`
2. Make sure `gulp` doesn't return any errors
3. Open `test/run.html` in your favorite browser
4. Make sure there are no errors in dev console
5. Make sure all dialogs behave correctly

Setting up the environment:

1. Run `npm install`
2. Run `bower install`

##Examples

HTML page example:
```html
<html>
<head>
  <meta charset="utf-8">
  <title>boostrap-waitingfor</title>
  <link href="bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet" />
  <link href="bower_components/bootstrap/dist/css/bootstrap-theme.css" rel="stylesheet" />
</head>
<body>
  <script src="../bower_components/jquery/dist/jquery.min.js"></script>
  <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
  <script src="../build/bootstrap-waitingfor.js"></script>
</body>
</html>
```
