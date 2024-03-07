#include <iostream>
// #include <conio.h> 
#include <Eigen/Dense>
#include <boost/numeric/odeint.hpp>
#include "test2.h"

using namespace std ;
using namespace Eigen;
namespace odeint = boost::numeric::odeint;
typedef std::array<double,2> state_type;



struct pendulum
{
double m_mu, m_omega, m_eps;
pendulum(double mu,double omega,double eps)
: m_mu(mu),m_omega(omega),m_eps(eps) { }
void operator()(const state_type &x,
state_type &dxdt,double t) const
{
dxdt[0] = x[1];
dxdt[1] = -sin(x[0]) - m_mu * x[1] +
m_eps * sin(m_omega*t);
}
};

int main(){
    
    odeint::runge_kutta4< state_type > rk4;

    pendulum p( 0.1 , 1.05 , 1.5 );
    state_type x = {{ 1.0 , 0.0 }};
    double t = 0.0;
    const double dt = 0.01;
    rk4.do_step( p , x , t , dt );
    t += dt;
    std::cout<<t<<" "<< x[0]<<" "<<x[1]<<"\n";
    for( int i=0 ; i<10 ; ++i )
        {
    rk4.do_step( p , x , t , dt );
    t += dt;
    std::cout<<t<<" "<< x[0]<<" "<<x[1]<<"\n";
        }

     
    cout << "Press Enter  to close the program" << endl;

    // while (!_kbhit()) { // Wait for a key press
    //     // Do nothing
    // }
    // _getch(); // Clear the key from buffer
    cin.ignore();
    
    return 0;
}
