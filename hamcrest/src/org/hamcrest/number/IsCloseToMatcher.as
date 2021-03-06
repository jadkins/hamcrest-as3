package org.hamcrest.number
{
    import org.hamcrest.Description;
    import org.hamcrest.TypeSafeMatcher;

    /**
     * Matches if a value is within +/- the error value from the given value.
     *
     * @see org.hamcrest.number.closeTo
     *
     * @example
     * <listing version="3.0">
     * assertThat(3, closeTo(4, 1));
     * // passes
     *
     * assertThat(3, closeTo(5, 0.5));
     * // fails
     *
     * assertThat(4.5, closeTo(5, 0.5));
     * // passes
     * </listing>
     *
     * @author Drew Bourne <andrew@firstbourne.com>
     */
    public class IsCloseToMatcher extends TypeSafeMatcher
    {
        private var _value:Number;
        private var _delta:Number;

        /**
         * Constructor.
         *
         * @param value
         * @param error
         */
        public function IsCloseToMatcher(value:Number, error:Number)
        {
            super(Number);
            _value = value;
            _delta = error;
        }

        /**
         * @inheritDoc
         */
        override public function matchesSafely(item:Object):Boolean
        {
            return (actualDelta(item as Number) <= 0.0);
        }

        /**
         * @inheritDoc
         */
        override public function describeMismatch(item:Object, mismatchDescription:Description):void
        {
            mismatchDescription
                .appendValue(item)
                .appendText(" differed by ")
                .appendValue(actualDelta(item as Number));
        }

        /**
         * @inheritDoc
         */
        override public function describeTo(description:Description):void
        {
            description
                .appendText("a Number within ")
                .appendValue(_delta)
                .appendText(" of ")
                .appendValue(_value);
        }

        /**
         * Calculate the actual delta between the expected value and the value being matched.
         */
        protected function actualDelta(item:Number):Number
        {
            return (Math.abs((item - _value)) - _delta);
        }
    }
}
