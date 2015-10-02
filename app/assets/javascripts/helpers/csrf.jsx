class Csrf {
  static getInput() {
    var csrfToken = this.getCsrfToken();
    var csrfParam = this.getCsrfParam();
    return `<input name=${csrfParam} value=${csrfToken} type='hidden'>`;
  }

  static getCsrfToken() {
    return document.querySelector('meta[name=csrf-token]').attributes.content.value;
  }

  static getCsrfParam() {
    return document.querySelector('meta[name=csrf-param]').attributes.content.value;
  }
}
