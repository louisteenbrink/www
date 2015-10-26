class Csrf {
  static getInput(token) {
    var csrfToken = this.getCsrfToken() || token;
    var csrfParam = this.getCsrfParam() || 'authenticity_token';
    return `<input name=${csrfParam} value=${csrfToken} type='hidden'>`;
  }

  static getCsrfToken() {
    if (typeof document !== 'undefined') {
      return document.querySelector('meta[name=csrf-token]').attributes.content.value;
    }
  }

  static getCsrfParam() {
    if (typeof document !== 'undefined') {
      return document.querySelector('meta[name=csrf-param]').attributes.content.value;
    }
  }
}
