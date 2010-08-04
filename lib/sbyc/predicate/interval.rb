#
# This file is extracted from the CRUC library (http://code.chefbe.net)
# which is distributed under the licence below. Please keep this header
# when using this class. Send an email to blambeau at gmail dot com if
# you need special usage rights.
#
# The MIT License
# Copyright (c) 2009 Bernard Lambeau and the University of Louvain 
# (Universite Catholique de Louvain, Louvain-la-Neuve, Belgium)
# 

#
# Provides a powerful interval implementation.
#
# == Pragmatically
# Intervals muts be created through the class factory:
#
#    # Creates an empty interval
#    Interval.empty()
#
#    # Creates an interval [0..10]
#    Interval.natural(0,10)
#
#    # Creates a left-opened interval ]0..10]
#    Interval.left_opened(0,10)
#
#    # Creates an interval containing all values greater than 5: ]5..+INF]
#    Interval.gt(5)
#
#    # Creates an interval containing all values greater or equal to 5: [5..+INF]
#    Interval.gte(5)
#
#    # Creates an interval containing all values: [-INF..+INF]
#    Interval.all()
# 
# == Theory
# We define an interval as a (not necessarily proper) subset of all values 
# defined by an ordered type (we use the Integer type in the documentation, 
# but you can use any type defining the <tt><=></tt> operator). Actually, the
# name _Interval_ comes from simple intervals (see below) but this class is not
# restricted to those. It provides a compact representation for any subset of 
# values. For the sake of simplicity, we distinguish simple from composite 
# intervals.
#
# === Simple interval
# A simple interval is the set of all values included between two boundaries 
# denoted by _first_ and _last_. First and last values are either included or 
# excluded from the interval. We note simple intervals with the following 
# syntax: 
# - <tt>[first..last]</tt> the set of values mathematically defined by 
#   <tt>{ x | x >= first and x <= last }</tt>
# - <tt>]first..last]</tt> the set of values mathematically defined by 
#   <tt>{ x | x > first and x <= last }</tt>
# - <tt>[first..last[</tt> the set of values mathematically defined by 
#   <tt>{ x | x >= first and x < last }</tt>
# - <tt>]first..last[</tt> the set of values mathematically defined by 
#   <tt>{ x | x > first and x < last }</tt>
# We refer to these kinds of interval as _natural_, <em>left_opened</em>,
# <em>right-opened</em> and <em>full-opened</em> respectively. Moreover, this
# class defines an INF constant (infinity), which can be used for interval 
# boundaries. This way, it's easy to create intervals representing 
# <em>less-than</em> and <em>greater-than</em>. For example, the interval 
# <tt>[0..+INF]</tt> represents positive integers <tt>{ x | x >= 0 }</tt>.    
#
# === Composite interval
# A composite interval is simply the set of values belonging to the mathematical
# union of simple intervals (refered to as <em>sub-intervals</em>). This 
# implementation is such that composite intervals are kept in a normal form: 
# sub-intervals are never overlaping (see overlap), kept in increasing
# order (according to their first value) and such that no two sub-intervals
# meet each other. A simple interval may be seen as a composite one containing 
# one sub-interval only; thus, simple intervals are always in normal form. 
#
# Example (+ stands for interval union) :
#     # the following interval: ]-5..15] + [-15..-2] + ]30..+INF] + [15..20[ 
#     # has the following normal form: [-15..20[ + ]30..+INF]
#     (left_opened(-5,15) + natural(-15,-2) + gt(30) + right_opened(15,20)) == (right_opened(-15,20) + gt(30))
#
# === Operators
# We provide here a short description of each operator defined on intervals.
# Definitions here assumes intervals in normal form. Documentation of methods
# provide additional explanations (including running time).
#
# Operator names and definitions are inspired by the following book: C.J. Date,
# Hugh Darwen and Nikos A. Lorentzos, <em>Temporal Data and The Relational Model.
# A detailed investigation into the Application of Interval and Relation Theory 
# to the Problem of Temporal Database Management</em>, Morgan Kaufmann Publishers 
# Inc., San Francisco, CA, 2002. The book only defines simple intervals. 
# The theory is extended here to composite intervals. 
#
# [size] The size of an interval is the number of sub-intervals it's normal form
#        contains. The size of a simple interval is always 1.
# [all?] True only for [-INF..+INF], false for all other intervals.
# [empty?] True if the set of values of the interval is the empty set. This 
#          class does not allow to create intervals for which the first value is
#          strictly lesser than the last one (which could be one way to create
#          empty intervals). For this reason, empty intervals are those that
#          have same value for first and last and at least one is excluded.
#          For example, <tt>]5..5]</tt> is an empty interval. By convention,
#          this class creates empty intervals as <tt>]-INF..-INF[</tt>
# [eql?] Two intervals are equal if they denote exactly the same subset of 
#        values. The == operator has the same semantics.
# [include?] An interval includes another if it is a (non necessarily proper) 
#            superset of values (i.e. it contains at least all values of the 
#            other one). <tt>strictly_include?</tt> requires the second not to 
#            contain first and last values of the former. See also the discussion
#            section about this operator.
# [before?] An interval is before another one if the greater value of the set it
#           represents is strictly less than the smaller value of the set of 
#           the other (i.e. <tt>i1.before?(i2) <=> i1.last < i2.first</tt>).
# [after?] Similarly, an interval is after another if the smaller value of the 
#          set it represents is stricly greater than the greater value of the
#          other (i.e. <tt>i1.after?(i2) <=> i1.first > i2.last</tt>). Note that
#          <tt>i1.before?(i2)</tt> is equivalent to <tt>i2.after?(i1)</tt>. 
# [meet?] Two intervals i1 and i2 meet if the greatest value of i1 is equal to 
#         the smallest value of i2 (or the converse) and one of them is excluded
#         while the other is included. Example: 
#         <tt>[-INF..0]</tt> and <tt>]0..+INF]</tt> meet as well as 
#         <tt>[-INF..0[</tt> and <tt>[0..+INF]</tt>  but <tt>[-INF..0]</tt> and 
#         <tt>[0..+INF]</tt> do not. See also the discussion section about this
#         operator.
# [overlap?] Two intervals overlap if the sets they define are not disjoint.
#            In other words, two intervals overlap if they have at least one 
#            value in common. The overlap? operator is thus commutative.
# [merge?] Two intervals merge if they overlap of meet. When two simple intervals
#          merge, then the normal form of their union only contains one 
#          sub-interval (i.e. it's size remains 1). When two composite intervals
#          merge, the size of their union in normal form is striclty lesser than
#          the sum of their respective size. See also the discussion section 
#          about this operator.
# [begin?] An interval (i1) begins another one (i2) if and only if i1 is simple,
#          is included in the first sub-interval of i2 and contains its smaller 
#          value. The begin_with? operator is a shortcut for <tt>i2.begin?(i1)</tt> 
# [end?] An interval (i1) ends another one (i2) if and only if i1 is simple,
#        is included in the last sub-interval of i2 and contains its greater
#        value. The end_with? operator is a shortcut for <tt>i2.end?(i1)</tt> 
# [complement] The complement of an interval is the complement of the set of 
#              values it defines (values that belong to the type and are not 
#              contained in the interval).
# [union] The union of two intervals (i1 and i2) follows the mathematical union 
#         on sets: an interval for which each value belongs to i1 or i2 or both.
#         The union operator is commutative.
# [intersection] The intersection of two intervals follows the mathematical 
#                intersection on sets: an interval with all values shared between
#                them. The intersection operator is commutative.
# [difference] The difference of an interval i1 with another interval i2 follows
#              the mathematical difference on sets: an interval with all values 
#              of i1 that are not shared by i2.
#
# == Discussion 
# As already stated, operators are inspired from C.J. Date's book about temporal
# data and relational databases. However, that book does not discuss composite
# intervals at all. While this class exactly implements the semantics of 
# operators defined in the book when operands are simple intervals, we've been
# forced to extend the theory to handle composite intervals as well. Moreover,
# intersection, union, difference and complement operators are not discussed in
# the book since they naturally lead to composite intervals.
#
# === About set based operators and methods
# By defining an interval as a (sub)set of values, all methods and operators 
# directly related to the set theory seem well defined (all?, empty?, eql?, 
# include?, included_in?, overlap? complement, union, intersection and difference) 
# and should not lead to any discussion.
#
# Methods relying on an ordered set definition may lead to discussion:
# [last and first] as well as include_first?, exclude_first?, include_last?,
#                  exclude_last? are well defined on simple intervals. Their 
#                  definition being the smallest and greatest values (respectively) 
#                  of the set of values captured by an interval, they are also 
#                  well defined on composite intervals. However, all these methods 
#                  are not particularly useful in the context of composite intervals. 
#                  Future extensions should include a boundary? (and others related)
#                  method that could be more useful.
# [strictly_include?] follows Date's definition for simple intervals and, while
#                     relying on the natural order of values, is well defined in
#                     this case. On composite intervals, the definition of this 
#                     operator leads is somewhat arbitrary: only the smallest and 
#                     greatest values of the set are required not to be in the 
#                     included set. Another interpretation could be that no 
#                     sub-interval boundary is present in the included set. 
#                     Following the set theory, we could also define  
#                     strictly_include relying on proper superset of values, but
#                     this would change the intuitive meaning of the operator 
#                     (only one boundary should then be absent of the included set). 
# [before? and after?] follow Date's definition for simple intervals. On composite
#                      intervals, their definitions are somewhat arbitrary once 
#                      again.
# [begin? and end?] same remark as before? and after?
# [meet? and merge?] same remark as before? and after?
#                    
# == Efficiency
# All methods defined in this class run in O(1) when interval operands are 
# simple (both simple in case of diadic operators). When at least one interval 
# operand is composite, some methods still run in O(1) while the majority of
# interval operators run in O(n), _n_ being always the sum of the sizes of the
# operands. In other words, all methods of this class run in linear time in the
# worst case.
#
# To keep the source clean, the code of this class is not particularly optimized. 
# Optimization could be made quite easily if innefficiencies are experimented.
#
class Interval
  
  ### constant and lambda tools ################################################
  
  # Infinity
  INF = 1.0/0.0
  
  ##############################################################################
  # Self-contained point methods.
  #
  # A self-contained point is simply an array [value, is_included, is_first, 
  # interval, index] where 
  # [value] is the point value in the interval
  # [is_included] true if the point is included in the interval, false otherwise
  # [is_first] true for first points, false for end points
  # [owner] Interval object, owner of this point (aka master interval)
  # [index] index of the sub-interval in which this point is included (in the
  #         @sub_intervals array of the master interval)
  #
  # A self-contained point (array) is always decorated with the methods of this
  # module, for easier use.   
  #
  module SelfContainedPoint
    include Comparable
    
    #
    # Copies this self contained point for another owner.
    #
    # Arguments:
    # [new_owner] new Interval instance for which this point is copied.
    # [index] index of the point copy in owner's @sub_intervals instance
    # variable.
    #
    # See also Interval#initialize for more informations. 
    #
    def copy_for_owner(new_owner, new_index)
      n = [self[0], self[1], self[2], new_owner, new_index]
      Interval.to_self_contained_point(*n)
    end
    
    # Returns the point value
    def value() return self[0] end
      
    # Returns true if this point is included in its interval, false otherwise
    def is_included?() return self[1] end

    # Retyurns true if this point is excluded from its interval, false otherwise
    def is_excluded?() return !self[1] end
      
    # Returns true if this point is the first in its interval, and false for 
    # last points      
    def is_first?() return self[2] end

    # Returns true if this point is the last in its interval, and true for 
    # first points      
    def is_last?() return !self[2] end
      
    # Returns the Interval owner.
    def owner() return self[3] end
          
    # Returns the index of the sub-interval (containing this point) in the master 
    # interval. 
    def index() return self[4] end

    #
    # Checks if this point meets another one.
    #
    # Two points meet in the following situations: e1[[b1, e1]]b1 and only
    # if they agree on their value (i.e. same value).
    #  
    # Note that answering the question makes only sense when the first point is 
    # a last one and the second is a first, or the reverse. This method:
    # 1. calls <tt>o.meet(self)</tt> if o is a end point and self is an begin 
    #    point. 
    # 2. raises an ArgumentError if they are both first or last points. 
    # 3. returns true if the points meet, false if they don't.
    #
    def meet?(o)
      raise ArgumentError unless o.is_a?(SelfContainedPoint)
      if is_first?
        raise ArgumentError, "meet does'nt make sense between first/first points" unless o.is_last?
        # i'm a first, o is a last -> reverse method call
        return o.meet?(self)
      else
        raise ArgumentError, "meet does'nt make sense between end/end points" unless o.is_first?
        # now, i'm an end point, o is a first point
        # efficient shortcut (ef) for (value <=> o.value) taking infinity into account 
        c = VALUE_COMPARATOR[self[0],o[0]]   
        if c==0
          # (self.is_included? and o.is_excluded?) or (self.is_excluded? and o.is_included?)
          return self[1] != o[1]
        else
          # we don't meet because not the same value
          return false 
        end        
      end
    end
      
    # Compares to another self-contained point
    def <=>(o)
      raise ArgumentError unless o.is_a?(SelfContainedPoint)
      # efficient shortcut (ef) for (value <=> o.value) taking infinity into account 
      c = VALUE_COMPARATOR[self[0],o[0]]   
      if c==0 # same values, a lot of ambiguities to resolve
        # ef: self.is_first?, o.is_first?, self.is_included?, o.is_included?
        me_first, o_first, me_incl, o_incl = self[2], o[2],self[1], o[1]    
        if me_first
          if o_first # first-first comparison
            # both included or not included -> equal: ([10.. <=> [10..) or (]10.001.. <=> ]10.001..)
            # i'm included, o is not -> i'm less:  [10.. <=> ]10.001..
            # i'm not included, o is -> i'm greater: ]10.001.. <=> [10..
            return (me_incl ? (o_incl ? 0 : -1) : (o_incl ? 1 : 0))
          else # first-last comparison
            # both included -> equal: [10.. <=> ..10]
            # i'm included, o is not -> i'm greater [10.. <=> ..9.99[
            # i'm not included -> i'm greater (]10.001.. <=> ..9.99[) or (]10.001.. <=> ..10])
            return me_incl ? (o_incl ? 0 : 1) : 1
          end
        else
          if o_first # last-first comparison
            # both included -> equal: ..10] <=> [10..
            # i'm included, o is not -> i'm less: ..10] <=> ]10.001..
            # i'm not included -> i'm less: (..9.99[ <=> [10..) or (..9.99[ <=> ]10.001..)
            return me_incl ? (o_incl ? 0 : -1) : -1
          else # last-last comparison
            # both included -> equal: ..10] <=> ..10]
            # both excluded -> equal: ..9.99[ <=> ..9.99[
            # i'm included, o is not -> i'm greater : ..10] <=> ..9.99[
            # i'm not included, o is -> i'm less: ..9.99[ <=> ..10]
            return me_incl ? (o_incl ? 0 : 1) : (o_incl ? -1 : 0)
          end
        end
      else # no ambiguity at all
        # not same values, reuse comparison result
        return c
      end
    end
    
    #
    # Compares this point with a given value.
    #
    # This method returns -1 if val is striclty less than the point value,
    # 0 if equal and 1 if it is strictly greater. 
    # 
    def value_compare(val)
      c = VALUE_COMPARATOR[self[0],val]
      if c==0
        # values are the same ambiguities
        return c if is_included?   # ..val] or [val..
        return 1 if is_first?      # ]val..
        return -1                  # ..val[
      else
        # no ambiguite, reuse comparison result
        return c
      end
    end
    
    # Returns an hash code
    def hash
      value.hash + (37*is_included?.hash) + (37*is_excluded?.hash)
    end
          
    # Returns a string representation
    def to_s
      s = ''
      if is_first? then s << (is_included?() ? '[' : ']') end
      s << value.to_s
      if is_first? then s << '..' end
      if is_last?  then s << '..' << (is_included?() ? ']' : '[') end
      return s
    end
      
  end # module SelfContainedPoint

  # Provides Interval.to_self_contained_point
  class << self
    #
    # Builds a self-contained point (see SelfContainedPoint).
    #
    # TODO: this method should be protected or private
    #
    def to_self_contained_point(value, is_included, is_first, owner, index)
      p = [value, is_included, is_first, owner, index]
      class << p
        include SelfContainedPoint
      end
      return p
    end
  end
  
  ##############################################################################
  # Factory of Intervals
  #
  # This module contains all methods to create intervals easily. It is already
  # included as class methods of the Interval class. You may also include it 
  # safely to your code for easier usage.
  #
  module Factory
    
    # Infinity
    INF = 1.0/0.0
    
    #
    # Creates an explicit interval.
    #
    # Arguments: 
    # [min] first point of the interval
    # [max] last point of the interval
    # [min_included] is first point included (true) or excluded (false)?
    # [max_included] is last point included (true) or excluded (false)? 
    #
    # If min>max, then the factored interval is the one that would be returned 
    # by <tt>interval(max,min,maxi,mini)</tt>. In other words, this method
    # automatically reverse the interval boundaries (as well as their inclusions)
    # when called with a negative interval.
    #
    def create(min, max, mini, maxi)
      return VALUE_COMPARATOR[max,min]<0 ? Interval.send(:new,max,min,maxi,mini) : 
                                           Interval.send(:new,min,max,mini,maxi)
    end
    alias :interval :create
        
    # Creates an empty interval: ]-INF,-INF[
    def empty() create(-INF,-INF,false,false) end
    
    # Creates an interval containing all values: [-INF,INF]
    def all() create(-INF,+INF,true,true) end
   
    # Creates a point interval [point,point]
    def point(p) create(p,p,true,true) end
     
    # 
    # Creates a natural interval [first,last]
    #
    # If first>last then the factored interval is [last,first]
    #
    def natural(first,last) create(first,last,true,true) end

    #      
    # Creates a left-opened interval ]first,last]
    #
    # If first>last then the factored interval is ]last,first]
    #
    def left_opened(first,last) create(first,last,false,true) end  

    #      
    # Creates a right-opened interval [first,last[
    #
    # If first>last then the factored interval is [last,first[
    #
    def right_opened(first,last) create(first,last,true,false) end  
      
    #      
    # Creates a full-opened interval ]first,last[
    #
    # If first>last then the factored interval is ]last,first[
    #
    def full_opened(first, last) create(first,last,false,false) end
      
    # Creates a less-than interval [-INF,val[
    def lt(val) create(-INF,val,true,false) end
      
    # Creates a less-than-or-equal-to interval [-INF,val]
    def lte(val) create(-INF,val,true,true) end
      
    # Creates a greater-than interval ]val,+INF]
    def gt(val) create(val,+INF,false,true) end
      
    # Creates a greater-than-or-equal-to interval [val,+INF]
    def gte(val) create(val,+INF,true,true) end
      
  end
  
  # Provides a user-friendly factory for intervals.
  class << self
    include Factory
  end
  
  ### Other utilities used below ###############################################
  
  # Provides merge sort and code generation utils
  module Utils
    
    #
    # Converts a value to a ruby literal.
    #
    # This method implements the following algorithm:
    # 1. If value responds to a :to_ruby_literal method, then it is invoked and 
    #    the returned value is returned by this method.
    # 2. If value if a String this method automatically quotes it.
    # 3. If value is equal to infinity, then '(1.0/0.0)' is returned.
    # 4. If value is equal to minus infinity, then '(-1.0/0.0)' is returned.
    # 3. Otherwise, the result of to_s is returned.
    #
    def self.to_ruby_literal(value)
      return value.to_ruby_literal if value.respond_to? :to_ruby_literal
      return "'" + value.to_s + "'" if value.is_a? String
      return "(1.0/0.0)" if value==(1.0/0.0)
      return "(-1.0/0.0)" if value==(-1.0/0.0)
      return value.to_s
    end
  
    # 
    # Well-known merge-sort algorithm.
    #
    # This algorithm sorts an arbitrary list of elements, returning a new array
    # containing all elements of _list_, in ascending order. Array elements are
    # assumed to implement the <=> operator.
    #
    # This algorithm has been copied from:
    # http://en.wikibooks.org/wiki/Algorithm_implementation/Sorting/Merge_sort#Ruby
    #
    def self.mergesort(list)
      return list if list.size <= 1
      mid = list.size / 2
      left  = list[0, mid]
      right = list[mid, list.size]
      Utils.merge_sorted!(mergesort(left), mergesort(right))
    end
  
  
    # 
    # Merges two sorted arrays, returning another sorted array containing all 
    # their elements. 
    #
    # Recall: merge_sorted returns an array containing all elements of left and 
    # right, in ascending order; left and right are assumed to be already sorted.
    # Actually this function is a sub function of the well known mergesort 
    # algorithm which sort arbitrary arrays by recursively calling this sub
    # function.
    #
    # _left_ and _right_'s element are assumed to implement the <=> operator.
    # Left and right arrays are modified by this algorithm! 
    #
    # This algorithm has been copied from:
    # http://en.wikibooks.org/wiki/Algorithm_implementation/Sorting/Merge_sort#Ruby
    #
    def self.merge_sorted!(left, right)
      sorted = []
      until left.empty? or right.empty?
        if left.first <= right.first
          sorted << left.shift
        else
          sorted << right.shift
        end
      end
      sorted.concat(left).concat(right) 
    end
    
  end  
  
  ### Interval class (attributes & constructor) ################################

  # Sub-intervals of this interval
  #--
  # This array always contains sub-intervals as arrays of [first,last] points.
  # That is: [[b1,e1], [b2,e2], ..., [bn, en]]. Those points must be 
  # SelfContainedPoints. See also SelfContainedPoint#copy_for_owner.
  #++
  attr_accessor :sub_intervals

  #  
  # Initializes a single interval (min,max).
  #
  # This constructor also allows to create an empty Interval object by passing
  # a nil argument for min. @sub_intervals of such an object should always be
  # set correctly after that (using the write accessor), otherwise strange 
  # results will surely occur. (see also developper documentation on top of 
  # attr_reader :sub_intervals to know the structure of that array, as well as
  # SelfContainedPoint#copy_for_owner).
  #
  def initialize(min, max, mini, maxi)
    if min
      raise ArgumentError, 'Interval min must be <= max (use factory instead)' if min>max
      first = Interval.to_self_contained_point(min,mini,true,self,0)
      last = Interval.to_self_contained_point(max,maxi,false,self,0)
      @sub_intervals = [[first,last]]
    end
  end
  
  ### Protected access to self contained points of the (sub-)intervals. ########
  protected
  #
  # Returns the [first,last] point array of the index'th sub-interval. First and
  # last points in this array are SelfContainedPoint.
  # 
  # This method does not check the validity of index. Negative indexes may be 
  # used to get the sub-intervals from the end.
  #
  def sub_interval_points(index)
    @sub_intervals[index]
  end
  
  #
  # Returns the first point of the index-th sub-interval. Returned point is a 
  # SelfContainedPoint (shortcut for sub_interval_points(index)[0])
  # 
  # This method does not check the validity of index. Negative indexes may be 
  # used to access first point of sub-intervals from the end.
  #
  def ith_first_point(index)
    sub_interval_points(index)[0]
  end
  
  #
  # Returns the last point of the index-th sub-interval. Returned point is a 
  # SelfContainedPoint (shortcut for sub_interval_points(index)[1])
  # 
  # This method does not check the validity of index. Negative indexes may be 
  # used to access last point of sub-intervals from the end.
  #
  def ith_last_point(index)
    sub_interval_points(index)[1]
  end
  
  #
  # Returns the first point of the first interval. Returned point is a 
  # SelfContainedPoint.
  #
  def first_point
    ith_first_point(0)
  end
  
  #
  # Returns the last point of the last interval. Returned point is a 
  # SelfContainedPoint.
  #
  def last_point
    ith_last_point(-1)
  end
  
  #
  # Returns an array containing all sub-interval first points, in ascending 
  # order.
  #
  # The returned array is a copy of internal structures so that it can be
  # modified by users.
  #
  def all_first_points
    @sub_intervals.collect {|si| si[0]}
  end
  
  #
  # Returns an array containing all sub-interval last points, in ascending 
  # order.
  #
  # The returned array is a copy of internal structures so that it can be
  # modified by users.
  #
  def all_last_points
    @sub_intervals.collect {|si| si[1]}
  end
    
  ### Public access to intervals main methods. #################################
  public
  #
  # Returns the number of sub-intervals this one contains.
  #
  # This method returns 1 if and only if this interval is simple (see simple?).
  # Be warned that the size of an interval is not the number of values it 
  # contains, but the number of sub-intervals of it's normal form.
  #
  def size() 
    @sub_intervals.size 
  end

  #
  # Checks if this interval is a simple one (contains only one sub-interval)
  #
  # This method is a shortcut for <tt>interval.size==1</tt>
  #
  def simple?() 
    size==1 
  end

  #
  # Checks if this interval is composite (contains more than one sub-interval)
  #
  # This method is a shortcut for <tt>interval.size>1</tt>
  #
  def composite?() 
    size>1 
  end

  #
  # Returns the value of the first point of this interval.
  #
  # Precisely, this method returns the value of the first point of the first 
  # sub-interval of self. 
  #
  def first() 
    first_point.value
  end  

  #    
  # Returns the value of the last point of this interval.
  #
  # Precisely, this method returns the value of the last point of the last 
  # sub-interval of self. 
  #
  def last() 
    last_point.value
  end  
  
  # 
  # Checks if this interval includes it's first point.
  #
  # Precisely, this method returns true if the first sub-interval of self 
  # includes it's first point.
  #
  def include_first?() 
    first_point.is_included? 
  end

  #
  # Semantically equivalent to not(include_first?)
  #
  def exclude_first?() 
    not(include_first?)
  end
  
  # 
  # Checks if this interval includes it's last point.
  #
  # Precisely, this method returns true if the last sub-interval of self 
  # includes it's last point.
  #
  def include_last?() 
    last_point.is_included?
  end

  #
  # Semantically equivalent to not(include_last?)
  #
  def exclude_last?() 
    not(include_last?)
  end
  
  ### Specific interval operators. #############################################
  
  #
  # Checks is this interval contains all possible values.
  #
  # The only interval that contains all possible values is [-INF,+INF].
  # Not that both first and last values must be included, so that ]-INF,+INF]
  # is not an all interval for example.
  # 
  # This method runs in O(1).
  # 
  def all?() 
    return false unless simple?
    f, l = first_point, last_point
    return (f.value==-INF) && (l.value==+INF) && 
           f.is_included?() && l.is_included?()
  end
  
  #
  # Checks if this interval is empty.
  #
  # By definition, an interval is empty if it is simple, its first and last 
  # values are the same and at least one of them is excluded. That is, 
  # <tt>]value,value]</tt>, <tt>[value,value[</tt> and <tt>]value,value[</tt> 
  # are empty intervals.
  # 
  # By convention, all empty intervals created by this class (that is, as the 
  # result of an interval operator) are ]-INF,-INF[. This method recognizes all 
  # empty intervals according to the 'mathematical' definition.
  #
  # This method runs in O(1).
  # 
  def empty?() 
    return false unless simple?
    f, l = first_point, last_point
    f.value==l.value and (!f.is_included? or !l.is_included?)
  end

  #
  # Checks if this interval equals another one.
  #
  # Two composite intervals are equal if they contain exactly the same 
  # sub-intervals. Two simple sub-intervals are equal if they agree on first and 
  # last value as well as their inclusion or exclusion.  
  #
  # This method runs in O(1).
  #
  def eql?(o)
    @sub_intervals==o.sub_intervals
  end
  
  # 
  # Semantically equivalent to <tt>self.eql?(o)</tt>
  #
  def ==(o)
    eql?(o)
  end
  
  #
  # Checks if this interval contains a given value.
  #
  # An simple interval contains a value _val_ if the set of values it captures
  # contains _val_. 
  #
  # If the value if another interval this method calls include? instead.
  # 
  # This method runs in O(self.size)
  #
  def contains?(val)
    return include?(val) if val.is_a?(Interval)
    return false if empty?
    return true if all?
    @sub_intervals.each do |sub|
      gte = sub[0].value_compare(val)<=0
      next unless gte
      lte = sub[1].value_compare(val)>=0
      return true if lte
    end
    return false
  end
  
  #
  # Checks if this interval includes another one.
  #
  # An interval (i1) includes another one (i2) if the set of values represented
  # by i1 is a (non necessarily proper) superset of those represented by i2 
  # (i.e. i1 contains at least all values of i2). 
  #
  # If _o_ is a value, this methods calls contains? instead.
  #
  # This method runs in O(self.size + o.size), which is linear. It implies that 
  # it runs in O(1) if self and o are both simple. If only self is simple, it 
  # runs in O(o.size); if only o is simple, in O(self.size).
  #
  def include?(o)
    return contains?(o) unless o.is_a?(Interval)
    return true if o.empty?
    if simple? and o.simple?
      # From Date's book: b1<=b2 and e1>=e2
      (first_point <= o.first_point) && (last_point >= o.last_point)
    elsif simple?
      # I'm simple, so I must include all o's sub-intervals
      o.each_sub_interval do |s|
        # the following line will necessary match the if above 
        # because i'm simple as well as s !
        return false unless self.include?(s) 
      end
      return true
    elsif o.simple?
      # o is simple, so at least one of my sub-intervals must include it
      self.each_sub_interval do |s|
        # the following line will necessary match the <tt>if simple? and o.simple?</tt>
        # above because o is simple as well as s !
        return true if s.include?(o)
      end
      return false
    else
      # o is not simple, neither do I
      # I include o if I don't gain anything in the union with o ! 
      return self.union(o) == self
    end
  end

  #
  # Checks if this interval strictly includes another one.
  #
  # An interval (i1) strictly includes another one (i2) if the set of values 
  # represented by i1 is a proper superset of those represented by i2 (i.e. i1 
  # contains at least all values of i2 but also values that are not in i2). 
  # Note that this method is equivalent to 
  # <tt>self.include?(o) and !self.eql?(o)</tt> 
  #
  # This method runs in O(1) if self and o are simple. Otherwise it runs
  # in O(self.size + o.size)
  #
  def strictly_include?(o) 
    if o.empty? then return true unless empty? end
    if simple? and o.simple?
      # From Date's book: b1<b2 and e1>e2
      (first_point < o.first_point) && (last_point > o.last_point)
    else
      # From definition
      # TODO: there's a better (more efficient) implementation for this, isn't?
      include?(o) && (self != o)
    end
  end
  
  #
  # Checks if this interval is included in another one.
  #
  # Semantically equivalent to <tt>o.include?(self)</tt>
  #
  def included_in?(o) return o.include?(self) end
  
  #  
  # Checks if this interval is strictly included in another one.
  #
  # Semantically equivalent to <tt>o.strictly_include?(self)</tt>
  #
  def strictly_included_in?(o) o.strictly_include?(self) end

  #
  # Checks if this interval is before another one.
  #
  # An interval is before another one if the greater value of the set it 
  # represents is strictly less than the smaller value of the set of the other
  # (i.e. <tt>i1.before?(i2) <=> i1.last < i2.first</tt>).
  #
  # This method runs in O(1)
  # 
  def before?(o)
    # From Date's book: e1<b2
    last_point < o.first_point 
  end

  #
  # Checks if this interval is after another one.
  #
  # Semantically equivalent to <tt>o.before?(self)</tt>
  #
  def after?(o) return o.before?(self) end

  #
  # Checks if this interval meets another one.
  #
  # Two intervals i1 and i2 meet if the greatest value of i1 is equal to the 
  # smallest value of i2 (or the converse) and one of them is excluded while 
  # the other is included.
  #
  # See discussion section about meet in the case of composite intervals.
  # 
  # Example: <tt>[-INF..0]</tt> and <tt>]0..+INF]</tt> meet as well as 
  # <tt>[-INF..0[</tt> and <tt>[0..+INF]</tt>  but <tt>[-INF..0]</tt> and 
  # <tt>[0..+INF]</tt> do not.
  # 
  # This method runs in O(1).
  #
  def meet?(o)
    # From Date's book: b2=e1+1 or b1=e2+1
    
    # Not really useful here, consider the first case b2=e1+1
    # (o's begin is just before my end), meaning that o's begin and my end are
    e1, b2 = last_point, o.first_point
    # the same value and we are in one of following cases: e1]]b2 or e1[[b2
    test = if e1.value==b2.value 
             (e1.is_included? and b2.is_excluded?) or
             (e1.is_excluded? and b2.is_included?)
           else false
           end
    return true if test
    
    # Not really useful here, consider the second case b1=e2+1
    # (my begin is just before o's end), meaning that my begin and o's end are
    # the same value and we are in one of following cases: e2]]b1 or e2[[b1
    b1, e2 = first_point, o.last_point
    test = if e2.value==b1.value
               (e2.is_included and b1.is_excluded) or
               (e2.is_excluded and b1.is_included)
           else false
           end
    return test
  end
  alias :touch? :meet?

  #
  # Checks if this interval overlaps another one.
  #
  # Two intervals overlap if the sets they define are not disjoint. In other 
  # words, two intervals overlap if they have at least one value in common. 
  # The overlap? operator is thus commutative.
  #
  # This method runs in O(1) if both intervals are simple. Otherwise, it runs
  # in O(self.size + o.size)
  #
  def overlap?(o)
    if o.empty? then return true end
    if simple? and o.simple?
      # From Date's book: b1<=e2 and b2<=e1
      (first_point <= o.last_point) and (o.first_point <= last_point)
    else
      # I overlap with o if our intersection is not empty
      return !self.intersection(o).empty?
    end
  end
  
  #
  # Checks if this interval can merge with another one (overlap or meet).
  # 
  # Two intervals merge if they overlap of meet. When two simple intervals merge, 
  # the normal form of their union only contains one sub-interval (i.e. the size 
  # of the result remains 1). When two composite intervals merge, the size of 
  # their union in normal form is striclty lesser than the sum of their 
  # respective size.
  #
  # This method runs in O(1) if both intervals are simple.
  # 
  def merge?(o)
    meet(o) or overlap(o)
  end
  
  #
  # Checks if this interval begins another one.
  #
  # An interval (i1) begins another one (i2) if and only if i1 is simple, is 
  # included in the first sub-interval of i2 and contains its smaller value.
  #
  # This method runs in O(1)
  #
  def begin?(o)
    # From Date's book: b1=b2 and e1<=e2 (for simple intervals). For composite
    # intervals, we require self to be simple and take b2 and e2 as the 
    # boundaries of the first o's sub-interval.
    simple? and (first_point == o.ith_first_point(0)) and 
                (last_point <= o.ith_last_point(0))
  end
  
  #
  # Checks if this interval begins with another one.
  #
  # Semantically equivalent to <tt>o.begin?(self)</tt>
  #
  def begin_with?(o) o.begin?(self) end
  
  #
  # Checks if this interval ends another one.
  #
  # An interval (i1) ends another one (i2) if and only if i1 is simple, is 
  # included in the last sub-interval of i2 and contains its greater value. 
  #
  # This method runs in O(1)
  #
  def end?(o)
    # From Date's book: e1=e2 and b1>=b2 (for simple invervals). For composite
    # intervals, we require self to be simple and take b2 and e2 as the 
    # boundaries of the last o's sub-interval.
    simple? and (last_point == o.ith_last_point(-1)) and 
                (first_point >= o.ith_first_point(-1))
  end
  
  #
  # Checks if this interval ends with another one
  #
  # Semantically equivalent to <tt>o.end?(self)</tt>
  #
  def end_with?(o) o.end?(self) end
  
  #
  # Enumerates all sub-intervals (Interval instances) of this interval, in 
  # increasing order.
  #
  # This method works for simple as well as composite intervals. The given block
  # is yield exactly self.size times.
  #
  def each_sub_interval # :yields: sub_interval
    size.times do |i|
      f, l = ith_first_point(i), ith_last_point(i)
      if block_given?
        yield Interval.send(:new,f.value, l.value, f.is_included?, l.is_included?)  
      end
    end
  end
  
  #
  # Returns the complement of this interval.
  # 
  # The complement of an interval is the complement of the set of values it 
  # defines (i.e. another interval containing all values of the data-type that
  # do not belong to the initial interval).
  #
  # This method runs in O(self.size)
  #
  def complement
    # don't spend too much time on these special cases
    return Interval.all() if self.empty?
    return Interval.empty() if self.all?
    
    # new owner (initially empty), it's point structure will be set at the
    # end of the algorithm 
    new_owner = Interval.send(:new,nil,nil,nil,nil)
    
    # new interval (will contains point pairs and will be the point structure
    # of owner)
    new_interval = []
    
    # will always contain the last end point we've encountered
    prev_end = nil
    
    # Walk through all sub-intervals
    @sub_intervals.each do |sub|
      # take its boundaries
      sub_first, sub_end = sub
  
      # first case is a bit tricky
      unless prev_end
        if sub_first.value==-INF and sub_first.is_included?
          # the first point [-INF, we just bypass this point
          prev_end = sub_end
          next
        else
          # three cases here (]-INF.. or [x.. or ]x..): in all cases we want 
          # the first interval to be [-INF.. So we put ]-INF which will be 
          # negated later 
          prev_end = Interval.to_self_contained_point(-INF,false,false,self,0) 
        end
      end
      
      raise unless prev_end.is_a? SelfContainedPoint
            
      # create the new interval
      new_first = Interval.to_self_contained_point(
        prev_end.value,              # first value is the last of previous end 
        prev_end.is_excluded?,       # it is included when the last was excluded
        true,                        # it is first
        new_owner,                   # for the new owner
        new_interval.size);          # will be next in the sub-intervals
      new_last = Interval.to_self_contained_point(
        sub_first.value,             # last value is the value of current first 
        sub_first.is_excluded?,      # it is included when the first was excluded
        false,                       # it is last
        new_owner,                   # for the new owner
        new_interval.size);          # will be next in the sub-intervals
      new_interval << [new_first, new_last]
      
      # continue with the next one
      prev_end = sub_end
    end
    
    # last case is a bit tricky too,
    # if the last point is +INF], we have nothing to add
    unless (prev_end.value==+INF and prev_end.is_included?)
      # otherwise (..x], ..x[, ..+INF[) we want to add (]x..+INF], [x..+INF],
      # [+INF..+INF]
      new_first = Interval.to_self_contained_point(
        prev_end.value,              # we keep x in all cases 
        prev_end.is_excluded?,       # it is included when the last was excluded
        true,                        # it is first
        new_owner,                   # for the new owner
        new_interval.size);          # will be next in the sub-intervals
      # new last in ..+INF] in all cases
      new_last = Interval.to_self_contained_point(+INF,true,false,new_owner,new_interval.size)
      new_interval << [new_first, new_last]
    end
    
    # now, we terminate, setting new interval (which is in fact an array of 
    # sub-intervals) to owner and returning the later.
    new_owner.sub_intervals = new_interval 
    return new_owner
  end
  
  # 
  # Semantically equivalent to self.complement()
  #
  def -@()
    self.complement()  
  end

  #
  # Computes the union of this interval with another one.
  #
  # The union of two intervals (i1 and i2) follows the mathematical union on 
  # sets: an interval for which each value belongs to i1 or i2 or both. The 
  # union operator is commutative.
  #
  # This method runs in O(self.size + o.size), which is linear.
  #
  def union(o)
    # don't spend too much time if one is empty!
    #--
    # the real reason is that the way empty intervals are implemented, this
    # function wouldn't work
    #++
    if empty? then return o
    elsif o.empty? then return self
    end
    
    # first sort the union of all first/last points of self and o.
    #--
    # The merge_sorted function (sub-function of mergesort algorithm) is used 
    # here to guarantee O(n) execution time), Ruby's Array.sort is in O(n*logn)
    #++
    all_first = Utils.merge_sorted!(all_first_points,o.all_first_points)
    all_last =  Utils.merge_sorted!(all_last_points, o.all_last_points)
    
    # number of first points (kept to avoid unecessary inefficiency)
    size = all_first.size
        
    # new owner (initially empty), it's point structure will be set at the
    # end of the algorithm 
    new_owner = Interval.send(:new,nil,nil,nil,nil)
    
    # new interval (will contains point pairs and will be the point structure
    # of owner)
    new_interval = []
    
    # will always contain the index (in all_first) of the next first
    # point to consider
    current = 0
    
    # will always contain the first point of the sub-interval under 
    # construction
    f = nil
    
    # last point initially associated to f, and updated when first points
    # are eaten (if associated to biggest last points than l)
    l = nil
    
    # Eat the whole first points
    while current < size
      # take the current point to consider (and increment)
      f = all_first[current]; current += 1
      
      # find associated last point
      l = f.owner.ith_last_point(f.index)
      
      # next first point to consider (kept to avoid unecessary inefficiency)
      nextf = all_first[current]
      
      # eat all first points that are included in (f,l), adapt l
      # if greater than the current one  
      while current<size and (nextf <= l or l.meet?(nextf))
        # adaptation
        nextl = nextf.owner.ith_last_point(nextf.index)
        l = nextl if (nextl > l)
        
        # increment
        current += 1
        nextf = all_first[current]
      end
      
      # we have found a new sub-interval here
      # copy of boundaries are added to new_interval
      new_index = new_interval.size
      new_interval << [f.copy_for_owner(new_owner,new_index),
                       l.copy_for_owner(new_owner,new_index)]
    end
    
    # now, we terminate, setting new interval (which is in fact an array of 
    # sub-intervals) to owner and returning the later.
    new_owner.sub_intervals = new_interval 
    return new_owner
  end
  
  # Semantically equivalent to <tt>union(o)</tt>
  def +(o) union(o); end

  #
  # Computes the intersection of this interval with another one.
  #
  # The intersection of two intervals follows the mathematical intersection on 
  # sets: an interval with all values shared between them. The intersection 
  # operator is commutative.
  #
  # This method runs in O(self.size + o.size), which is linear.
  #
  def intersection(o)
    # don't spend too much time if one is empty!
    #--
    # the real reason is that the way empty intervals are implemented, this
    # function wouldn't probably work
    #++
    if empty? then return self
    elsif o.empty? then return o
    end
    
    # take all points of me and o
    my_points, o_points = self.sub_intervals.dup, o.sub_intervals.dup  
        
    # new owner (initially empty), it's point structure will be set at the
    # end of the algorithm 
    new_owner = Interval.send(:new,nil,nil,nil,nil)
    
    # new interval (will contains point pairs and will be the point structure
    # of owner)
    new_interval = []

    # take two (first,last) pairs
    b1, e1 = my_points.shift # don't parallelize these two lines, it won't work!
    b2, e2 = o_points.shift
    
    # somewhat like a mergesort -> try to empty one of the both!
    # each iteration, we avance on one of the two lists, which guarantee O(n)
    # execution time!
    #--
    # Don't replace breaks by a trivial until or while, it won't work!
    #++
    while true
      if e1<b2  # meaning [b1..e1].before?([b2..e2])
        # we have the situation below 
        #   [b1..e1]
        #              [b2..e2]
        # skip [b1..e1], continue with [b2..e2]
        break if my_points.empty?
        b1, e1 = my_points.shift 
      elsif e2<b1  # meaning [b2..e2].before?([b1..e1])
        # we have the situation below 
        #              [b1..e1]
        #   [b2..e2]
        # skip [b2..e2], continue with [b1..e1]
        break if o_points.empty?
        b2, e2 = o_points.shift
      else
        # we have found a new sub-interval here!
        
        # now, different situations can occur. However, in all of them, we've
        # got some invariants. Consider the following situation: 
        #             [b1   ...   e1]
        #     [b2   ....  e2]
        # 1. we must create an new sub interval [b1..e2], [bmax..emin] in general. 
        # 2. e2 will become the new begin for me and shift will be made on o.
        #    in general: owner of emin will be shifted, emin will become the new
        #    begin for the other  
        
        # first, save different references
        bmax = b1>b2 ? b1 : b2
        emin, emax, non_owner = e1<e2 ? [e1,e2,o] : [e2,e1,self]
        
        # copy of boundaries are added to new_interval
        new_index = new_interval.size
        new_interval << [bmax.copy_for_owner(new_owner,new_index),
                         emin.copy_for_owner(new_owner,new_index)]
        
        # now, transform emin to a begin point on non_owner 
        # (last index is wrong but will never be used)
        new_first = Interval.to_self_contained_point(emin.value,emin.is_included?,true,non_owner,0)

        # split the cases (we use object_id to be sure who is who)
        if non_owner.object_id == self.object_id
          # i'm the non_owner, o is the owner
          # owner of emin (o) will be shifted, emin will become the new
          # begin for the other (me)
          break if o_points.empty?
          b1 = new_first
          b2, e2 = o_points.shift 
        else
          # i'm the owner, o is the non_owner
          # owner of emin (me) will be shifted, emin will become the new
          # begin for the other (o)
          break if my_points.empty?
          b2 = new_first
          b1, e1 = my_points.shift
        end
      end
    end
        
    # no intersection at all, return an empty (which is not implemented with an
    # empty structure of points!
    return Interval.empty() if new_interval.empty?
    
    # now, we terminate, setting new interval (which is in fact an array of 
    # sub-intervals) to owner and returning the later.
    new_owner.sub_intervals = new_interval 
    return new_owner
  end
  
  #
  # Computes the difference of this interval with another one.
  #
  # The difference of an interval i1 with another interval i2 follows the 
  # mathematical difference on sets: an interval with all values of i1 that are 
  # not shared by i2.
  #
  # This method runs in O(self.size + o.size)
  #
  def difference(o)
    # don't spend too much time on these special cases
    return self if empty? or o.empty?   # {empty}\{...}={empty}, {...}\{empty}={...}
    return Interval.empty() if o.all?   # {...}\{all values} = {empty}
    return -o if all?                   # {all values}\{...} = -{...}
    
    # well, we use the following mathematical property of difference:
    #         A minus B 
    #     <=> A intersection complement(B)
    #     <=> complement(complement(A intersection complement(B))) 
    #     <=> complement(complement(A) union B)
    # not really efficient, but it works
    # TODO: find a much more efficient algorithm for Interval.difference
    self.complement().union(o).complement() 
  end
  
  #
  # Semantically equivalent to difference.
  #
  def -(o)
    difference(o)
  end
  
  ### Other utility method. ####################################################
  
  #
  # Computes an hash code for this interval.
  #
  # This method is such that equal intervals have same hash code.
  #
  # Intervals being unmodifiable, the hash code if kept in cache. This way,
  # this method runs in O(self.size) the first time it is called, and in O(1)
  # after that.
  # 
  def hash()
    @hash_code ||= @sub_intervals.hash() unless @hash_code
  end
  
  # Returns a string representation of this interval
  def to_s
    s = ''
    size.times do |i|
      f = ith_first_point(i)
      fval = f.value
      s << (f.is_included?() ? "[" : "]") 
      s << (fval==-INF ? '-INF' : fval==+INF ? '+INF' : fval.to_s) << '..'
      l = ith_last_point(i)
      lval = l.value
      s << (lval==-INF ? '-INF' :  lval==+INF ? '+INF' : lval.to_s) 
      s << (l.is_included?() ? "]" : "[")
    end
    return s
  end
  
  #
  # Returns a chunck of ruby code allowing to test if a given value is included
  # in this interval.
  #
  # This method factors parsable ruby expressions that can be used for testing
  # inclusion of a given value (represented by a variable 'x' in the returned 
  # code expression) in the interval. The name of the variable to use may be
  # provided as first argument.
  #
  # Example:
  # - An interval <tt>[0..20]</tt> generates the ruby expression <tt>x >=0 and x <= 20</tt>
  # - An interval <tt>[-INF..25[[50..+INF</tt> generates the ruby expression
  #   <tt>x<25 or x>=50</tt>
  # - More complex intervals always lead to a Disjunctive Normal Form (CNF), i.e.
  #   a disjunction of conjunctions, each conjunction being the expression of a 
  #   sub-interval. 
  # 
  def to_ruby_code(varname='x')
    return 'true' if all?
    return 'false' if empty?
    varname = varname.to_s if varname.is_a?(Symbol)
    
    if simple?
      fvalue, lvalue, finc, linc = first, last, include_first?, include_last? 
      if fvalue == lvalue
        # we know that they are both included, otherwise this interval would be empty
        return varname.dup << '==' << Utils.to_ruby_literal(fvalue)
      else
        # values are different
        memo = ''
        if fvalue==-INF and finc          
          # something like [-INF..a -> (x </= a)
          memo << varname << (linc ? '<=' : '<') << Utils.to_ruby_literal(lvalue)
        elsif lvalue==+INF and linc       
          # something like a..+INF] -> (x >/= a)
          memo << varname << (finc ? '>=' : '>') << Utils.to_ruby_literal(fvalue)
        else                              
          # something like a..b (maybe INFs but not included) -> (x >/= a and x </= b)
          memo << varname << (finc ? '>=' : '>') << Utils.to_ruby_literal(fvalue)
          memo << ' and '
          memo << varname << (linc ? '<=' : '<') << Utils.to_ruby_literal(lvalue)
        end
        return memo
      end
    else
      args = [varname]
      memo = ''
      each_sub_interval do |sub|
        memo << ' or ' unless memo==''
        memo << '(' << sub.to_ruby_code(varname) << ')'
      end 
      return memo     
    end
  end
  
  #
  # Returns a lambda function that answers to contain?
  #
  def to_ruby_lambda()
    Kernel.eval %Q{
      Kernel.lambda {|x|
        #{to_ruby_code()}
      }
    }
  end
  
  # Provides a comparator of interval values, taking infinity values into 
  # account  
  #--
  # This constant is defined here as a hack to avoid a ugly rdoc bug (which seems
  # not a allow multi-line constants. 
  #++
  VALUE_COMPARATOR = Kernel.lambda {|p,q|
    if p==-INF
      return q==-INF ? 0 : -1
    elsif q==-INF
      return 1
    elsif p==+INF
      return q==+INF ? 0 : 1
    elsif q==+INF
      return -1
    else
      return p <=> q
    end
  }

  protected :sub_intervals, :sub_intervals=
  private_class_method :new
  
end # class Interval
