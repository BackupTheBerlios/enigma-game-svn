/*
 * Copyright (C) 2002,2003,2004 Daniel Heck
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
 *
 * $Id: math.hh,v 1.7 2004/02/16 00:23:54 dheck Exp $
 */
#ifndef PX_MATH_HH_INCLUDED
#define PX_MATH_HH_INCLUDED

#include <cmath>
#include <iosfwd>

namespace px
{

/* -------------------- Functions -------------------- */

    template <class T, class V>
    inline T round_nearest (V v) 
    {
        if (v > 0)
            return static_cast<T>(floor(v + 0.5));
        else
            return static_cast<T>(ceil(v - 0.5));
    }

    template <class T, class V>
    inline T round_down (V v) 
    {
        return static_cast<T>(floor(v));
    }

#if defined(i386) && defined (__GNUC__)

    template <>
    inline
    int round_nearest<int, double> (double v)
    {
	int result;
	int oldcword, cword;
	__asm__ __volatile__ (
            "fnstcw	%2\n\t"
            "movw	%2, %%ax\n\t"
            "andb       $243, %%ah\n\t"
            "movw	%%ax, %3\n\t"
            "fldcw	%3\n\t"
            "fistl	%0\n\t"
            "fldcw	%2\n\t"
            : "=m" (result)
            : "t" (v), "m" (oldcword), "m" (cword)
            : "%eax"		// clobbers eax
            );
	return result;
    }


    template <>
    inline
    int round_down<int, double> (double v)
    {
	int result;
	int oldcword, cword;
	__asm__ __volatile__ (
            "fnstcw	%2\n\t"
            "movw	%2, %%ax\n\t"
            "andb       $243, %%ah\n\t"
            "orb        $4, %%ah\n\t"
            "movw	%%ax, %3\n\t"
            "fldcw	%3\n\t"
            "fistl	%0\n\t"
            "fldcw	%2\n\t"
            : "=m" (result)
            : "t" (v), "m" (oldcword), "m" (cword)
            : "%eax"		// clobbers eax
            );
	return result;
    }

#endif

/* -------------------- Vector class -------------------- */

    template <typename T, int N>
    class Vector
    {
        T v[N];
        typedef Vector<T, N> vector_type;
    protected:
    	class noinit {};
    	Vector(noinit) {}
    public:

        // Constructors.
        Vector() {
            for (int i=N-1; i>=0; --i)
                v[i] = 0;
        }
        explicit Vector(T* w) {
            for (int i=N-1; i>=0; --i)
                v[i] = w[i];
        }

        // Copy constructor & assignment
        Vector(const vector_type & x) {
            for (int i=N-1; i>=0; --i)
                v[i] = x.v[i];
        }
        vector_type& operator=(const vector_type & x) {
            if (&x != this)
                for (int i=N-1; i>=0; --i)
                    v[i] = x.v[i];
            return *this;
        }

        // Normalization
        T normalize() {
            T l = std::sqrt( (*this) * (*this) );
            if (l != 0)
                (*this) /= l;
            return l;
        }


        // Addition and subtraction
        vector_type & operator+= (const vector_type & x) {
            for (int i=N-1; i>=0; --i)
                v[i] += x.v[i];
            return *this;
        }
        vector_type & operator-= (const vector_type & x) {
            for (int i=N-1; i>=0; --i)
                v[i] -= x.v[i];
            return *this;
        }

        // scalar multiplication
        vector_type & operator*= (T a) {
            for (int i=N-1; i>=0; --i)
                v[i] *= a;
            return *this;
        }
        // scalar division
        vector_type & operator/= (T a) {
            for (int i=N-1; i>=0; --i)
                v[i] /= a;
            return *this;
        }

        // scalar product
        T operator*(const vector_type & x) const {
            double sp = 0;
            for (int i=N-1; i>=0; --i)
                sp += v[i]*x.v[i];
            return sp;
        }

        T& operator[](int idx) { return v[idx]; }
        const T& operator[](int idx) const { return v[idx]; }
    };

    // negation
    template <typename T, int N>
    inline Vector<T,N>
    operator- (const Vector<T,N> &a)
    {
        Vector<T,N> res(a);
        for (int i=N-1; i>=0; --i)
            res[i]= -res[i];
        return res;
    }

    template <typename T, int N>
    inline double
    length(const Vector<T,N> &a)
    {
        return std::sqrt(a*a);
    }

    template <typename T, int N>
    inline double
    square (const Vector<T,N> &a)
    {
        return a*a;
    }


    template <typename T, int N>
    inline Vector<T,N>
    normalize(const Vector<T,N> &a)
    {
        if (T aa=length(a))
            return a/aa;
        else
            return a;
    }

    template <typename T, int N>
    inline Vector<T,N>
    operator+ (const Vector<T,N> & a,
               const Vector<T,N> & b)
    {
        Vector<T,N> res (a);
        res += b;
        return res;
    }

    template <typename T, int N>
    inline Vector<T,N>
    operator- (const Vector<T,N> & a,
               const Vector<T,N> & b)
    {
        Vector<T,N> res (a);
        res -= b;
        return res;
    }

    // scalar multiplication in different operand orders
    template <typename T, int N>
    inline Vector<T,N>
    operator*(const Vector<T,N> & v, double a)
    {
        Vector<T,N> res (v);
        res *= a;
        return res;
    }
    template <typename T, int N>
    inline Vector<T,N>
    operator*(double a, const Vector<T,N> & v)
    {
        Vector<T,N> res (v);
        res *= a;
        return res;
    }

    // scalar division in different operand orders
    template <typename T, int N>
    inline Vector<T,N>
    operator/(const Vector<T,N> & v, double a)
    {
        Vector<T,N> res (v);
        res /= a;
        return res;
    }
    template <typename T, int N>
    inline Vector<T,N>
    operator/(double a, const Vector<T,N> & v)
    {
        Vector<T,N> res (v);
        res /= a;
        return res;
    }


    template <typename T, int N>
    inline bool
    operator==(const Vector<T,N> & v,const Vector<T,N> & w)
    {
        for (int i=N-1; i>=0; --i)
            if (v[i] != w[i])
                return false;
        return true;
    }

    template <typename T, int N>
    inline bool
    operator!=(const Vector<T,N> & v,const Vector<T,N> & w)
    {
        return !(v == w);
    }

    class V3 : public Vector<double, 3> {
    public:
    	V3() {}
	V3(double x, double y, double z) :
	    Vector<double, 3>(noinit())
	{
	    (*this)[0] = x;
	    (*this)[1] = y;
	    (*this)[2] = z;
	}
        V3(const Vector<double,3> &v_) : Vector<double,3>(v_) {}
        V3 &operator=(const Vector<double,3> &v_) {
            Vector<double,3>::operator=(v_);
            return *this;
        }
    };

    //typedef Vector<double, 3> V3;
    inline V3
    crossprod(const V3 & a, const V3 & b)
    {
        V3 r;
	r[0] = a[1]*b[2] - a[2]*b[1];
        r[1] = a[2]*b[0] - a[0]*b[2];
        r[2] = a[0]*b[1] - a[1]*b[0];
        return r;
    }

    std::ostream& operator<<(std::ostream& os, const V3 & v);

    class V2 : public Vector<double, 2> {
    public:
	typedef double T;

    	V2() {}
	V2(T x, T y) :
	    Vector<T,2>(noinit())
	{
	    (*this)[0] = x;
	    (*this)[1] = y;
	}
        V2 (const Vector<T,2> &v_) : Vector<T,2>(v_) {}
        V2 &operator=(const Vector<T,2> &v_) {
            Vector<T,2>::operator=(v_);
            return *this;
        }
    };

    std::ostream& operator<<(std::ostream& os, const V2 & v);
}
#endif
