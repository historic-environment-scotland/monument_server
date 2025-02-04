import React from 'react';
import Logo from 'images/hes-logo-white2.png'
// import Logo from 'images/logo-2019-inverted.png'
import SquareLogo from 'images/hes-small.png'

import Form from './Form.jsx'
import Login from './Login.jsx'

export default class Nav extends React.Component {
  constructor(props) {
    super(props);
    this.state = {     
      collapsed: false,
    }

  }

  // this is really hacky and bad, but I'm really tired.
  toggleNav = () => {
    this.setState({collapsed: !this.state.collapsed});
    this.props.handleToggleNav()
  }

  
  render() {
    const {collapsed} = this.state
    return (
      <nav className={collapsed ? "collapsed" : "full"}>
        <img src={collapsed ? SquareLogo : Logo} onClick={this.toggleNav} className="pointer w-50 flex center pa3"/>
        {collapsed ? (
          // collapsed nav
              <div className="nav-content"></div>
        ) : (
          // normal nav
          <div className="nav-content">
            <div className="mb3 mt2">
              <button 
                className={this.props.viewDataVis ? "w-50 br--left active-button" : "w-50 br--left"} 
                onClick={this.props.handleToggle}>Data</button>
              <button 
                className={this.props.viewDataVis ? "w-50 br--right white" : "w-50 br--right active-button"} 
                onClick={this.props.handleToggle}>Images</button>
            </div>
            <Form siteNames={this.props.siteNames} tags={this.props.tags} refineView={this.props.refineView} email={this.props.userEmail} siteName={this.props.siteName}/>
          </div>
        )}

      </nav>
    )
  }
}